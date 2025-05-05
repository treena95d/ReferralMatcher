# OAuth Configuration Guide for ReferralHub

This guide provides step-by-step instructions for configuring Google and LinkedIn OAuth providers for your ReferralHub instance. Follow these steps to ensure OAuth works correctly in both development and production environments.

## Environment Variables

Add the following environment variables to your `.env` file:

```
# OAuth Configuration
AUTH_CALLBACK_DOMAIN=your-production-domain.com

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# LinkedIn OAuth
LINKEDIN_CLIENT_ID=your_linkedin_client_id
LINKEDIN_CLIENT_SECRET=your_linkedin_client_secret
```

The `AUTH_CALLBACK_DOMAIN` variable is especially important as it explicitly tells the application which domain to use for OAuth callbacks, overriding all other domain detection methods.

## Google OAuth Setup

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Navigate to "APIs & Services" > "Credentials"
4. Click "Create Credentials" > "OAuth client ID"
5. Select "Web application" as the application type
6. Add the following JavaScript origins:
   - `https://your-production-domain.com`
   - `https://your-app-name.replit.app` (if deploying on Replit)
   - `http://localhost:5000` (for local development)
7. Add the following redirect URIs:
   - `https://your-production-domain.com/api/auth/google/callback`
   - `https://your-app-name.replit.app/api/auth/google/callback` (if deploying on Replit)
   - `http://localhost:5000/api/auth/google/callback` (for local development)
8. Copy the generated Client ID and Client Secret to your environment variables

## LinkedIn OAuth Setup

1. Go to the [LinkedIn Developer Portal](https://www.linkedin.com/developers/)
2. Create a new app or select an existing one
3. Navigate to "Auth" tab
4. Add the following redirect URLs:
   - `https://your-production-domain.com/api/auth/linkedin/callback`
   - `https://your-app-name.replit.app/api/auth/linkedin/callback` (if deploying on Replit)
   - `http://localhost:5000/api/auth/linkedin/callback` (for local development)
5. Under OAuth 2.0 scopes, add:
   - `r_emailaddress`
   - `r_liteprofile`
6. Copy the generated Client ID and Client Secret to your environment variables

## Domain Verification

Some OAuth providers require domain verification to ensure you own the domain used for callbacks:

### Google Domain Verification
1. In Google Cloud Console, go to "APIs & Services" > "OAuth consent screen"
2. Under "Authorized domains", add your production domain
3. Follow the verification process (usually involves adding a DNS record or HTML file)

### LinkedIn Domain Verification
1. In LinkedIn Developer Portal, go to your app settings
2. Under "Settings" > "Website URL", add your production domain
3. Follow any verification instructions provided

## Troubleshooting

If you encounter OAuth issues, check the following:

1. **Callback URL Mismatch**: Ensure the exact callback URLs in your OAuth provider settings match what the application is using. Check the server logs to see what callback URL is being used.

2. **Environment Variables**: Verify all required environment variables are correctly set.

3. **Scope Issues**: If you get permission errors, you may need to adjust the scopes requested.

4. **Cookie/Session Issues**: Make sure your cookies are being properly set and maintained (especially important if using secure cookies).

5. **HTTPS Requirements**: OAuth providers require HTTPS for production callbacks. Ensure your production site uses HTTPS.

6. **Check Server Logs**: The application logs detailed information about OAuth setup at startup. Check the logs for any configuration issues or errors.

## Debug Mode

For development, you can enable additional OAuth debugging by setting:

```
NODE_ENV=development
```

This will log additional OAuth details to help diagnose issues.