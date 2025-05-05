#!/bin/bash
# Production deployment script for ReferralHub
# Run with: bash deploy.sh

set -e  # Exit immediately if a command exits with a non-zero status

echo "🚀 Starting deployment process for ReferralHub..."
start_time=$(date +%s)

# Check for Node.js and npm
if ! command -v node &> /dev/null; then
  echo "❌ Node.js is not installed! Please install Node.js 18 or higher."
  exit 1
fi

# Check Node.js version (require 18+)
node_version=$(node -v | cut -d 'v' -f 2 | cut -d '.' -f 1)
if [ "$node_version" -lt 18 ]; then
  echo "❌ Node.js version 18 or higher is required. Current version: $(node -v)"
  exit 1
fi

# Check required environment variables
echo "📋 Verifying environment variables..."
required_vars=(
  "DATABASE_URL" 
  "SESSION_SECRET" 
  "SENDGRID_API_KEY" 
  "EMAIL_FROM" 
  "GOOGLE_CLIENT_ID" 
  "GOOGLE_CLIENT_SECRET" 
  "LINKEDIN_CLIENT_ID" 
  "LINKEDIN_CLIENT_SECRET"
)

# Recommended but not required variables
recommended_vars=(
  "AUTH_CALLBACK_DOMAIN"
  "REPLIT_SLUG"
  "SITE_URL"
  "CUSTOM_DOMAIN"
)

missing_vars=()
for var in "${required_vars[@]}"; do
  if [ -z "${!var}" ]; then
    missing_vars+=("$var")
  fi
done

if [ ${#missing_vars[@]} -gt 0 ]; then
  echo "❌ Missing required environment variables:"
  for var in "${missing_vars[@]}"; do
    echo "   - $var"
  done
  echo "Please set these environment variables before continuing."
  echo "See .env.example for a list of all required variables."
  exit 1
fi

echo "✅ All required environment variables are set"

# Check for recommended environment variables
missing_recommended=()
for var in "${recommended_vars[@]}"; do
  if [ -z "${!var}" ]; then
    missing_recommended+=("$var")
  fi
done

if [ ${#missing_recommended[@]} -gt 0 ]; then
  echo "⚠️ Missing recommended environment variables:"
  for var in "${missing_recommended[@]}"; do
    echo "   - $var"
  done
  echo "These variables are recommended for OAuth and deployment configuration."
  echo "See OAUTH_SETUP.md for detailed configuration instructions."
fi

# Install production dependencies
echo "📦 Installing production dependencies..."
npm ci --production || npm install --production

# Create necessary directories
echo "📂 Creating necessary directories..."
mkdir -p uploads/resumes
mkdir -p logs

# Run database migrations
echo "🔄 Running database migrations..."
npm run db:migrate

# Build the frontend
echo "🏗️ Building the frontend..."
NODE_ENV=production npm run build

# Run tests (if available)
if [ -f "package.json" ] && grep -q "\"test\":" "package.json"; then
  echo "🧪 Running tests..."
  npm test
else
  echo "⚠️ No tests available to run"
fi

# Set production environment
export NODE_ENV=production

# Create a deployment archive (optional)
timestamp=$(date +"%Y%m%d%H%M%S")
archive_name="referralhub-$timestamp.tar.gz"
echo "📦 Creating deployment archive: $archive_name"
tar --exclude='node_modules' --exclude='.git' --exclude="$archive_name" -czf "$archive_name" .
echo "✅ Deployment archive created"

# Display summary
end_time=$(date +%s)
duration=$((end_time - start_time))
echo ""
echo "✅ Deployment preparation complete!"
echo "⏱️ Total time: $duration seconds"
echo ""
echo "To start the application in production mode:"
echo "  NODE_ENV=production npm start"
echo ""
echo "To restore from the archive later:"
echo "  tar -xzf $archive_name"
echo ""