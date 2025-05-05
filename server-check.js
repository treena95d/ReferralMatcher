#!/usr/bin/env node
/**
 * ReferralHub Server Health Check Utility
 * 
 * This script performs a quick external health check of the application.
 * It can be used by monitoring systems, container orchestration, or CI/CD pipelines.
 * 
 * Usage: 
 *   node server-check.js [url] [--timeout ms] [--verbose]
 * 
 * Example:
 *   node server-check.js https://referralhub.com/health --timeout 5000 --verbose
 */

const https = require('https');
const http = require('http');

// Parse command line arguments
const args = process.argv.slice(2);
const url = args[0] || 'http://localhost:5000/health';
const timeout = args.includes('--timeout') 
  ? parseInt(args[args.indexOf('--timeout') + 1], 10) || 3000 
  : 3000;
const verbose = args.includes('--verbose');

// Parse the provided URL
function parseUrl(urlString) {
  try {
    const parsedUrl = new URL(urlString);
    return {
      protocol: parsedUrl.protocol,
      hostname: parsedUrl.hostname,
      port: parsedUrl.port || (parsedUrl.protocol === 'https:' ? 443 : 80),
      path: parsedUrl.pathname,
      valid: true
    };
  } catch (error) {
    return { valid: false, error: error.message };
  }
}

// Perform the health check
function checkServerHealth(urlString, timeoutMs) {
  return new Promise((resolve, reject) => {
    const startTime = Date.now();
    const parsedUrl = parseUrl(urlString);
    
    if (!parsedUrl.valid) {
      return reject(new Error(`Invalid URL: ${parsedUrl.error}`));
    }
    
    const client = parsedUrl.protocol === 'https:' ? https : http;
    
    const options = {
      hostname: parsedUrl.hostname,
      port: parsedUrl.port,
      path: parsedUrl.path,
      method: 'GET',
      timeout: timeoutMs,
      headers: {
        'User-Agent': 'ReferralHub-HealthCheck/1.0',
      }
    };
    
    if (verbose) {
      console.log(`Checking health at ${urlString} (timeout: ${timeoutMs}ms)...`);
    }
    
    const req = client.request(options, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        const responseTime = Date.now() - startTime;
        
        try {
          const responseData = data ? JSON.parse(data) : {};
          
          resolve({
            statusCode: res.statusCode,
            healthy: res.statusCode >= 200 && res.statusCode < 300,
            responseTime,
            data: responseData
          });
        } catch (error) {
          resolve({
            statusCode: res.statusCode,
            healthy: res.statusCode >= 200 && res.statusCode < 300,
            responseTime,
            error: 'Invalid JSON response',
            data: data
          });
        }
      });
    });
    
    req.on('error', (error) => {
      reject(error);
    });
    
    req.on('timeout', () => {
      req.destroy();
      reject(new Error(`Request timed out after ${timeoutMs}ms`));
    });
    
    req.end();
  });
}

// Run the health check
checkServerHealth(url, timeout)
  .then(result => {
    if (verbose) {
      console.log('Health check result:');
      console.log(JSON.stringify(result, null, 2));
    }
    
    if (result.healthy) {
      console.log(`✅ Server is healthy (${result.responseTime}ms)`);
      process.exit(0);
    } else {
      console.error(`❌ Server is not healthy! Status code: ${result.statusCode}`);
      if (verbose && result.data) {
        console.error('Response:', result.data);
      }
      process.exit(1);
    }
  })
  .catch(error => {
    console.error('❌ Health check failed:', error.message);
    process.exit(1);
  });