const express = require('express');
const path = require('path');
const app = express();

// Serve static files
app.use(express.static(path.join(__dirname, 'client/public')));

// Route for the test page
app.get('/test', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Simple Test Server</title>
      <style>
        body { font-family: Arial, sans-serif; padding: 20px; max-width: 800px; margin: 0 auto; }
        h1 { color: #ff5a5f; }
        .card { border: 1px solid #ddd; border-radius: 8px; padding: 20px; margin-top: 20px; }
      </style>
    </head>
    <body>
      <h1>ReferralHub Simple Test Server</h1>
      <p>Current time: ${new Date().toLocaleString()}</p>
      
      <div class="card">
        <h2>Server is working!</h2>
        <p>If you can see this page, the simple Express server is running correctly.</p>
      </div>
      
      <div class="card">
        <h2>Status</h2>
        <ul>
          <li>Server running: Yes</li>
          <li>Time started: ${new Date().toLocaleString()}</li>
          <li>Environment: ${process.env.NODE_ENV || 'development'}</li>
        </ul>
      </div>
    </body>
    </html>
  `);
});

// Catch-all route for API testing
app.get('/api/test', (req, res) => {
  res.json({
    status: 'ok',
    message: 'API endpoint is working',
    timestamp: new Date().toISOString()
  });
});

// Default route
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>ReferralHub Test</title>
      <style>
        body { font-family: Arial, sans-serif; padding: 20px; max-width: 800px; margin: 0 auto; }
        h1 { color: #ff5a5f; }
        .card { border: 1px solid #ddd; border-radius: 8px; padding: 20px; margin-top: 20px; }
      </style>
    </head>
    <body>
      <h1>ReferralHub Root Page</h1>
      <p>The application is running but the full React app is not loading.</p>
      
      <div class="card">
        <h2>Test Links</h2>
        <ul>
          <li><a href="/test">Test Page</a></li>
          <li><a href="/api/test">API Test (JSON)</a></li>
        </ul>
      </div>
    </body>
    </html>
  `);
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Simple test server running at http://localhost:${PORT}`);
});