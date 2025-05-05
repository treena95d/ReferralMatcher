#!/bin/bash

# Create referrers for SDE2 at Microsoft (Job ID: 1)
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (SDE)",
  "title": "Software Development Engineer",
  "companyId": 1,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+DM&background=random",
  "bio": "7+ years of experience in software development. Expert in cloud computing and distributed systems.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567890",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 8,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'

# Create referrers for PM at Google (Job ID: 2)
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (PM)",
  "title": "Product Manager",
  "companyId": 2,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+PM&background=random",
  "bio": "8+ years of experience in product management. Expertise in building high-impact products.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567891",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 8,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'

# Create referrers for ML Engineer (Job ID: 3)
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (ML)",
  "title": "Machine Learning Engineer",
  "companyId": 1,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+ML&background=random",
  "bio": "6+ years of experience in machine learning and AI. Expert in Python and ML frameworks.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567892",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 6,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'

# Create a referrer at Amazon
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (Amazon)",
  "title": "Senior Software Engineer",
  "companyId": 3,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+AWS&background=random",
  "bio": "10+ years of experience in AWS and cloud infrastructure. Helping talented engineers join Amazon.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567893",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 10,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'

# Create a referrer at Meta
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (Meta)",
  "title": "Engineering Manager",
  "companyId": 4,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+Meta&background=random",
  "bio": "9+ years of experience in social media technologies. Leading engineering teams at Meta.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567894",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 9,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'

# Create a referrer at Apple
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (Apple)",
  "title": "iOS Developer",
  "companyId": 5,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+iOS&background=random",
  "bio": "7+ years of experience in iOS development. Expert in Swift and Apple ecosystem.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567895",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 7,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'

# Create a referrer at Netflix
curl -X POST -H "Content-Type: application/json" http://localhost:5000/api/referrers -d '{
  "name": "Treena Dutta Majumdar (Netflix)",
  "title": "Data Scientist",
  "companyId": 6,
  "rating": 5,
  "photo": "https://ui-avatars.com/api/?name=Treena+DS&background=random",
  "bio": "8+ years of experience in data science and analytics. Expert in recommendation systems.",
  "email": "treena.duttamajumdar@example.com",
  "phone": "+1234567896",
  "linkedinUrl": "https://linkedin.com/in/treena-dm",
  "yearsOfExperience": 8,
  "notifyEmail": true,
  "notifyWhatsapp": true
}'
