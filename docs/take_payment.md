# Integrating Square Payments for Ticket Sales on Hugo Site

This guide explains how to integrate Square's payment system into your Hugo site to sell event tickets, products, or services directly from your static website.

## What is Square?

Square is a comprehensive payment processing platform that offers:

- **Easy Integration**: Simple APIs and embeddable payment forms
- **Security**: PCI-compliant payment processing
- **Multiple Payment Methods**: Credit cards, digital wallets, buy now pay later
- **Real-time Processing**: Immediate transaction confirmation
- **Dashboard**: Comprehensive sales and analytics dashboard
- **Mobile Ready**: Responsive payment forms that work on all devices

## Step-by-Step Implementation

### Step 1: Set Up Square Developer Account

1. **Create Square Developer Account**:
   - Go to [https://developer.squareup.com](https://developer.squareup.com)
   - Sign up or log in with existing Square account
   - Create a new application

2. **Get API Credentials**:
   - Navigate to your application dashboard
   - Note your **Application ID** (starts with `sq0idb-`)
   - Note your **Access Token** (starts with `EAAAl` for sandbox, `EAAAE` for production)
   - Use **Sandbox** for testing, **Production** for live transactions

3. **Configure Application Settings**:
   - Set application name and description
   - Add your website domain to allowed origins
   - Configure webhook endpoints (optional)

### Step 2: Create Ticket Sales Page

1. **Create ticket sales content**:
   ```bash
   hugo new content tickets.md
   ```

2. **Edit ticket sales page** (`content/tickets.md`):
   ```yaml
   +++
   title = "Purchase Tickets"
   date = "2025-09-19"
   draft = false
   description = "Secure your tickets for the Annual Symposium 2025"
   layout = "tickets"
   type = "tickets"
   
   [params]
     square_app_id = "YOUR_SQUARE_APPLICATION_ID"
     square_location_id = "YOUR_SQUARE_LOCATION_ID"
   +++

   # Purchase Your Tickets

   Secure your spot at the Annual Symposium 2025. Choose from our available ticket options below.

   ## Ticket Types

   ### Early Bird Special
   **$120** - Available until September 30, 2025
   - Full access to all sessions
   - Welcome breakfast and networking lunch
   - Conference materials and swag bag
   - Digital access to session recordings

   ### Regular Admission
   **$150** - Standard pricing
   - Full access to all sessions
   - Welcome breakfast and networking lunch
   - Conference materials and swag bag
   - Digital access to session recordings

   ### Student Rate
   **$75** - Valid student ID required
   - Full access to all sessions
   - Welcome breakfast and networking lunch
   - Conference materials
   - Digital access to session recordings

   ### VIP Experience
   **$250** - Limited availability
   - Priority seating at all sessions
   - VIP reception with speakers
   - Premium lunch experience
   - Exclusive networking opportunities
   - Conference materials and premium swag bag
   - Digital access to session recordings
   ```

### Step 3: Create Square Payment Layout

1. **Create tickets layout** (`layouts/tickets/tickets.html`):
   ```html
   {{ define "main" }}
   <div class="tickets-page">
     <div class="container">
       <div class="tickets-header">
         <h1>{{ .Title }}</h1>
         <p>{{ .Description }}</p>
       </div>

       <div class="tickets-content">
         {{ .Content }}
       </div>

       <div class="ticket-selector">
         <h2>Select Your Tickets</h2>
         
         <div class="ticket-options">
           <div class="ticket-option" data-price="12000" data-name="Early Bird Special">
             <div class="ticket-card">
               <h3>Early Bird Special</h3>
               <div class="price">$120</div>
               <div class="price-note">Until Sept 30</div>
               <ul class="features">
                 <li>✓ Full access to all sessions</li>
                 <li>✓ Welcome breakfast & lunch</li>
                 <li>✓ Conference materials</li>
                 <li>✓ Session recordings</li>
               </ul>
               <button class="select-ticket-btn" onclick="selectTicket(this)">
                 Select Early Bird
               </button>
             </div>
           </div>

           <div class="ticket-option" data-price="15000" data-name="Regular Admission">
             <div class="ticket-card">
               <h3>Regular Admission</h3>
               <div class="price">$150</div>
               <div class="price-note">Standard pricing</div>
               <ul class="features">
                 <li>✓ Full access to all sessions</li>
                 <li>✓ Welcome breakfast & lunch</li>
                 <li>✓ Conference materials</li>
                 <li>✓ Session recordings</li>
               </ul>
               <button class="select-ticket-btn" onclick="selectTicket(this)">
                 Select Regular
               </button>
             </div>
           </div>

           <div class="ticket-option" data-price="7500" data-name="Student Rate">
             <div class="ticket-card">
               <h3>Student Rate</h3>
               <div class="price">$75</div>
               <div class="price-note">Valid student ID required</div>
               <ul class="features">
                 <li>✓ Full access to all sessions</li>
                 <li>✓ Welcome breakfast & lunch</li>
                 <li>✓ Conference materials</li>
                 <li>✓ Session recordings</li>
               </ul>
               <button class="select-ticket-btn" onclick="selectTicket(this)">
                 Select Student
               </button>
             </div>
           </div>

           <div class="ticket-option featured" data-price="25000" data-name="VIP Experience">
             <div class="ticket-card">
               <h3>VIP Experience</h3>
               <div class="price">$250</div>
               <div class="price-note">Limited availability</div>
               <ul class="features">
                 <li>✓ Priority seating</li>
                 <li>✓ VIP speaker reception</li>
                 <li>✓ Premium lunch experience</li>
                 <li>✓ Exclusive networking</li>
                 <li>✓ Premium swag bag</li>
               </ul>
               <button class="select-ticket-btn" onclick="selectTicket(this)">
                 Select VIP
               </button>
             </div>
           </div>
         </div>
       </div>

       <!-- Attendee Information Form -->
       <div class="attendee-form" id="attendee-form" style="display: none;">
         <h2>Attendee Information</h2>
         
         <form id="ticket-form">
           <div class="form-row">
             <div class="form-group">
               <label for="first-name">First Name *</label>
               <input type="text" id="first-name" name="firstName" required>
             </div>
             <div class="form-group">
               <label for="last-name">Last Name *</label>
               <input type="text" id="last-name" name="lastName" required>
             </div>
           </div>

           <div class="form-group">
             <label for="email">Email Address *</label>
             <input type="email" id="email" name="email" required>
           </div>

           <div class="form-group">
             <label for="organization">Organization/Company</label>
             <input type="text" id="organization" name="organization">
           </div>

           <div class="form-group">
             <label for="title">Job Title</label>
             <input type="text" id="title" name="title">
           </div>

           <div class="form-row">
             <div class="form-group">
               <label for="phone">Phone Number</label>
               <input type="tel" id="phone" name="phone">
             </div>
             <div class="form-group">
               <label for="dietary">Dietary Restrictions</label>
               <input type="text" id="dietary" name="dietary" placeholder="None, Vegetarian, etc.">
             </div>
           </div>

           <div class="form-group">
             <label>
               <input type="checkbox" id="marketing" name="marketing" value="yes">
               I would like to receive updates about future events
             </label>
           </div>

           <div class="form-group">
             <label>
               <input type="checkbox" id="terms" name="terms" required>
               I agree to the <a href="/terms/" target="_blank">Terms and Conditions</a> *
             </label>
           </div>
         </form>
       </div>

       <!-- Payment Section -->
       <div class="payment-section" id="payment-section" style="display: none;">
         <h2>Payment Information</h2>
         
         <div class="order-summary">
           <h3>Order Summary</h3>
           <div class="summary-line">
             <span id="ticket-type-summary">Early Bird Special</span>
             <span id="ticket-price-summary">$120.00</span>
           </div>
           <div class="summary-line total">
             <strong>Total: <span id="total-price">$120.00</span></strong>
           </div>
         </div>

         <!-- Square Payment Form will be inserted here -->
         <div id="card-container"></div>
         
         <button id="card-button" type="button" class="pay-button">
           Complete Purchase
         </button>

         <div class="payment-status" id="payment-status"></div>
       </div>
     </div>
   </div>

   <!-- Square Web Payments SDK -->
   <script type="application/javascript" src="https://sandbox-web.squarecdn.com/v1/square.js"></script>
   <script>
     const appId = '{{ .Params.square_app_id }}';
     const locationId = '{{ .Params.square_location_id }}';
   </script>
   {{ end }}
   ```

### Step 4: Add Square Payment JavaScript

1. **Create Square payment script** (`assets/js/square-payments.js`):
   ```javascript
   // Global variables
   let payments;
   let card;
   let selectedTicket = null;

   // Initialize Square Payments
   async function initializeSquare() {
     if (!window.Square) {
       throw new Error('Square.js failed to load properly');
     }

     try {
       payments = window.Square.payments(appId, locationId);
     } catch (error) {
       console.error('Failed to initialize Square payments:', error);
       return;
     }

     try {
       card = await payments.card();
       await card.attach('#card-container');
     } catch (error) {
       console.error('Failed to initialize card payment method:', error);
     }
   }

   // Ticket selection functionality
   function selectTicket(button) {
     // Remove previous selections
     document.querySelectorAll('.ticket-option').forEach(option => {
       option.classList.remove('selected');
     });
     
     // Mark current selection
     const ticketOption = button.closest('.ticket-option');
     ticketOption.classList.add('selected');
     
     // Store selected ticket data
     selectedTicket = {
       name: ticketOption.dataset.name,
       price: parseInt(ticketOption.dataset.price), // Price in cents
       priceDisplay: (parseInt(ticketOption.dataset.price) / 100).toFixed(2)
     };
     
     // Update summary
     updateOrderSummary();
     
     // Show attendee form
     document.getElementById('attendee-form').style.display = 'block';
     
     // Scroll to form
     document.getElementById('attendee-form').scrollIntoView({ 
       behavior: 'smooth' 
     });
   }

   // Update order summary
   function updateOrderSummary() {
     if (!selectedTicket) return;
     
     document.getElementById('ticket-type-summary').textContent = selectedTicket.name;
     document.getElementById('ticket-price-summary').textContent = `$${selectedTicket.priceDisplay}`;
     document.getElementById('total-price').textContent = `$${selectedTicket.priceDisplay}`;
   }

   // Validate attendee form
   function validateAttendeeForm() {
     const form = document.getElementById('ticket-form');
     const requiredFields = form.querySelectorAll('[required]');
     
     for (let field of requiredFields) {
       if (!field.value.trim()) {
         field.focus();
         showStatus('Please fill in all required fields.', 'error');
         return false;
       }
     }
     
     // Validate email format
     const email = document.getElementById('email').value;
     const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     if (!emailRegex.test(email)) {
       document.getElementById('email').focus();
       showStatus('Please enter a valid email address.', 'error');
       return false;
     }
     
     return true;
   }

   // Get attendee data
   function getAttendeeData() {
     const form = document.getElementById('ticket-form');
     const formData = new FormData(form);
     const data = {};
     
     for (let [key, value] of formData.entries()) {
       data[key] = value;
     }
     
     return data;
   }

   // Handle payment
   async function handlePayment() {
     if (!selectedTicket) {
       showStatus('Please select a ticket first.', 'error');
       return;
     }
     
     if (!validateAttendeeForm()) {
       return;
     }
     
     const attendeeData = getAttendeeData();
     
     try {
       showStatus('Processing payment...', 'info');
       
       const result = await card.tokenize();
       
       if (result.status === 'OK') {
         const token = result.token;
         
         // Send payment to your backend
         const response = await fetch('/api/process-payment', {
           method: 'POST',
           headers: {
             'Content-Type': 'application/json',
           },
           body: JSON.stringify({
             token: token,
             amount: selectedTicket.price,
             currency: 'USD',
             attendee: attendeeData,
             ticket: selectedTicket
           })
         });
         
         const data = await response.json();
         
         if (response.ok && data.success) {
           showStatus('Payment successful! Check your email for confirmation.', 'success');
           
           // Redirect to thank you page
           setTimeout(() => {
             window.location.href = '/ticket-confirmation/?order=' + data.orderId;
           }, 2000);
         } else {
           throw new Error(data.error || 'Payment failed');
         }
       } else {
         throw new Error('Card tokenization failed: ' + result.errors[0].message);
       }
     } catch (error) {
       console.error('Payment error:', error);
       showStatus('Payment failed: ' + error.message, 'error');
     }
   }

   // Show status messages
   function showStatus(message, type) {
     const statusDiv = document.getElementById('payment-status');
     statusDiv.className = `payment-status ${type}`;
     statusDiv.textContent = message;
     statusDiv.style.display = 'block';
     
     if (type === 'success') {
       setTimeout(() => {
         statusDiv.style.display = 'none';
       }, 5000);
     }
   }

   // Form submission handler
   document.addEventListener('DOMContentLoaded', function() {
     // Initialize Square when form is shown
     let squareInitialized = false;
     
     // Watch for payment section to become visible
     const observer = new MutationObserver(function(mutations) {
       mutations.forEach(function(mutation) {
         if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
           const paymentSection = document.getElementById('payment-section');
           if (paymentSection && paymentSection.style.display !== 'none' && !squareInitialized) {
             initializeSquare();
             squareInitialized = true;
           }
         }
       });
     });
     
     // Start observing
     const paymentSection = document.getElementById('payment-section');
     if (paymentSection) {
       observer.observe(paymentSection, { attributes: true });
     }
     
     // Attendee form submission
     document.getElementById('ticket-form').addEventListener('submit', function(e) {
       e.preventDefault();
       
       if (validateAttendeeForm()) {
         document.getElementById('payment-section').style.display = 'block';
         document.getElementById('payment-section').scrollIntoView({ 
           behavior: 'smooth' 
         });
       }
     });
     
     // Add submit button to attendee form
     const submitButton = document.createElement('button');
     submitButton.type = 'submit';
     submitButton.className = 'btn btn-primary';
     submitButton.textContent = 'Proceed to Payment';
     document.getElementById('ticket-form').appendChild(submitButton);
     
     // Payment button handler
     const payButton = document.getElementById('card-button');
     if (payButton) {
       payButton.addEventListener('click', handlePayment);
     }
   });
   ```

### Step 5: Add Ticket Styles

1. **Create ticket styles** (`assets/css/tickets.css`):
   ```css
   /* Ticket Sales Styles */
   .tickets-page {
     padding: 2rem 0 4rem;
   }

   .tickets-header {
     text-align: center;
     margin-bottom: 3rem;
   }

   .tickets-header h1 {
     color: #333;
     margin-bottom: 1rem;
   }

   .ticket-selector {
     margin: 3rem 0;
   }

   .ticket-selector h2 {
     text-align: center;
     margin-bottom: 2rem;
     color: #333;
   }

   .ticket-options {
     display: grid;
     grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
     gap: 2rem;
     margin-bottom: 3rem;
   }

   .ticket-option {
     transition: transform 0.3s ease;
   }

   .ticket-option.featured {
     transform: scale(1.05);
   }

   .ticket-option.selected {
     transform: scale(1.02);
   }

   .ticket-card {
     background: white;
     border: 2px solid #e0e0e0;
     border-radius: 12px;
     padding: 2rem;
     text-align: center;
     height: 100%;
     display: flex;
     flex-direction: column;
     transition: all 0.3s ease;
     box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
   }

   .ticket-option:hover .ticket-card {
     border-color: #667eea;
     box-shadow: 0 4px 20px rgba(102, 126, 234, 0.2);
   }

   .ticket-option.selected .ticket-card {
     border-color: #667eea;
     background-color: #f8f9ff;
     box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
   }

   .ticket-option.featured .ticket-card {
     border-color: #ff6b6b;
     background: linear-gradient(135deg, #fff 0%, #fff8f8 100%);
   }

   .ticket-card h3 {
     color: #333;
     margin-bottom: 1rem;
     font-size: 1.4rem;
   }

   .price {
     font-size: 2.5rem;
     font-weight: bold;
     color: #667eea;
     margin-bottom: 0.5rem;
   }

   .ticket-option.featured .price {
     color: #ff6b6b;
   }

   .price-note {
     color: #666;
     font-size: 0.9rem;
     margin-bottom: 1.5rem;
   }

   .features {
     list-style: none;
     padding: 0;
     margin: 1.5rem 0;
     flex-grow: 1;
   }

   .features li {
     padding: 0.5rem 0;
     color: #555;
     border-bottom: 1px solid #f0f0f0;
   }

   .features li:last-child {
     border-bottom: none;
   }

   .select-ticket-btn {
     background-color: #667eea;
     color: white;
     border: none;
     padding: 1rem 2rem;
     border-radius: 8px;
     font-weight: bold;
     cursor: pointer;
     transition: all 0.3s ease;
     margin-top: auto;
   }

   .select-ticket-btn:hover {
     background-color: #5a6fd8;
     transform: translateY(-2px);
   }

   .ticket-option.featured .select-ticket-btn {
     background-color: #ff6b6b;
   }

   .ticket-option.featured .select-ticket-btn:hover {
     background-color: #ee5a52;
   }

   .ticket-option.selected .select-ticket-btn {
     background-color: #28a745;
   }

   /* Attendee Form Styles */
   .attendee-form {
     background: #f8f9fa;
     padding: 2rem;
     border-radius: 12px;
     margin: 3rem 0;
   }

   .attendee-form h2 {
     color: #333;
     margin-bottom: 2rem;
     text-align: center;
   }

   .form-row {
     display: grid;
     grid-template-columns: 1fr 1fr;
     gap: 1rem;
   }

   .form-group {
     margin-bottom: 1.5rem;
   }

   .form-group label {
     display: block;
     margin-bottom: 0.5rem;
     font-weight: bold;
     color: #555;
   }

   .form-group input,
   .form-group select {
     width: 100%;
     padding: 0.75rem;
     border: 1px solid #ddd;
     border-radius: 4px;
     font-size: 1rem;
     box-sizing: border-box;
   }

   .form-group input:focus,
   .form-group select:focus {
     outline: none;
     border-color: #667eea;
     box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
   }

   .form-group input[type="checkbox"] {
     width: auto;
     margin-right: 0.5rem;
   }

   /* Payment Section Styles */
   .payment-section {
     background: white;
     padding: 2rem;
     border: 2px solid #e0e0e0;
     border-radius: 12px;
     margin: 3rem 0;
   }

   .payment-section h2 {
     color: #333;
     margin-bottom: 2rem;
     text-align: center;
   }

   .order-summary {
     background: #f8f9fa;
     padding: 1.5rem;
     border-radius: 8px;
     margin-bottom: 2rem;
   }

   .order-summary h3 {
     margin-bottom: 1rem;
     color: #333;
   }

   .summary-line {
     display: flex;
     justify-content: space-between;
     padding: 0.5rem 0;
     border-bottom: 1px solid #e0e0e0;
   }

   .summary-line:last-child {
     border-bottom: none;
   }

   .summary-line.total {
     font-size: 1.2rem;
     font-weight: bold;
     color: #333;
     margin-top: 1rem;
     padding-top: 1rem;
     border-top: 2px solid #333;
   }

   /* Square Card Container */
   #card-container {
     margin: 2rem 0;
     padding: 1rem;
     border: 1px solid #e0e0e0;
     border-radius: 8px;
     background: white;
   }

   .pay-button {
     background-color: #28a745;
     color: white;
     border: none;
     padding: 1rem 2rem;
     border-radius: 8px;
     font-size: 1.1rem;
     font-weight: bold;
     cursor: pointer;
     width: 100%;
     transition: background-color 0.3s ease;
   }

   .pay-button:hover {
     background-color: #218838;
   }

   .pay-button:disabled {
     background-color: #ccc;
     cursor: not-allowed;
   }

   /* Payment Status */
   .payment-status {
     margin-top: 1rem;
     padding: 1rem;
     border-radius: 4px;
     display: none;
   }

   .payment-status.success {
     background-color: #d4edda;
     color: #155724;
     border: 1px solid #c3e6cb;
   }

   .payment-status.error {
     background-color: #f8d7da;
     color: #721c24;
     border: 1px solid #f5c6cb;
   }

   .payment-status.info {
     background-color: #d1ecf1;
     color: #0c5460;
     border: 1px solid #bee5eb;
   }

   /* Responsive Design */
   @media (max-width: 768px) {
     .ticket-options {
       grid-template-columns: 1fr;
     }

     .form-row {
       grid-template-columns: 1fr;
     }

     .attendee-form,
     .payment-section {
       padding: 1rem;
     }

     .ticket-option.featured {
       transform: none;
     }
   }
   ```

### Step 6: Backend Payment Processing

1. **Create payment API endpoint** (this would be a serverless function or separate backend):

   **Example for Netlify Functions** (`netlify/functions/process-payment.js`):
   ```javascript
   const { Client, Environment } = require('squareup');

   const client = new Client({
     accessToken: process.env.SQUARE_ACCESS_TOKEN,
     environment: process.env.NODE_ENV === 'production' 
       ? Environment.Production 
       : Environment.Sandbox
   });

   exports.handler = async (event, context) => {
     if (event.httpMethod !== 'POST') {
       return {
         statusCode: 405,
         body: JSON.stringify({ error: 'Method not allowed' })
       };
     }

     try {
       const { token, amount, currency, attendee, ticket } = JSON.parse(event.body);

       const paymentsApi = client.paymentsApi;
       
       const request = {
         sourceId: token,
         amountMoney: {
           amount: amount,
           currency: currency
         },
         idempotencyKey: Date.now().toString()
       };

       const response = await paymentsApi.createPayment(request);

       if (response.result) {
         // Payment successful
         const orderId = response.result.payment.id;
         
         // Send confirmation email (implement your email service)
         await sendConfirmationEmail(attendee, ticket, orderId);
         
         // Store order in database (implement your database)
         await storeOrder({
           orderId,
           attendee,
           ticket,
           amount,
           status: 'completed'
         });

         return {
           statusCode: 200,
           body: JSON.stringify({
             success: true,
             orderId: orderId
           })
         };
       } else {
         throw new Error('Payment failed');
       }
     } catch (error) {
       console.error('Payment processing error:', error);
       
       return {
         statusCode: 400,
         body: JSON.stringify({
           success: false,
           error: error.message || 'Payment processing failed'
         })
       };
     }
   };

   async function sendConfirmationEmail(attendee, ticket, orderId) {
     // Implement email sending logic
     // Could use SendGrid, AWS SES, etc.
   }

   async function storeOrder(orderData) {
     // Implement order storage logic
     // Could use Airtable, Firebase, etc.
   }
   ```

### Step 7: Create Confirmation Page

1. **Create confirmation page**:
   ```bash
   hugo new content ticket-confirmation.md
   ```

2. **Edit confirmation content**:
   ```yaml
   +++
   title = "Ticket Purchase Confirmation"
   date = "2025-09-19"
   draft = false
   description = "Thank you for your ticket purchase"
   layout = "confirmation"
   +++

   # Purchase Confirmation

   Thank you for purchasing your ticket! You should receive a confirmation email shortly with your ticket details and event information.

   ## What's Next?

   1. **Check your email** for the confirmation message
   2. **Save the date**: October 15, 2025
   3. **Review the schedule** and plan your day
   4. **Connect with us** on social media for updates

   ## Need Help?

   If you have any questions about your purchase or the event:

   - Email: [support@lamoni.com](mailto:support@lamoni.com)
   - Phone: (555) 123-4567
   - Check our [FAQ page](/symposium/faq/)

   [Return to Symposium Page](/symposium/)
   ```

### Step 8: Testing and Deployment

1. **Test with Square Sandbox**:
   ```bash
   # Use sandbox credentials for testing
   SQUARE_APPLICATION_ID=sandbox-sq0idb-xxx
   SQUARE_ACCESS_TOKEN=EAAAl-sandbox-xxx
   ```

2. **Test payment flows**:
   - Use Square's test card numbers
   - Test different ticket types
   - Verify email confirmations
   - Check error handling

3. **Deploy to production**:
   - Update to production Square credentials
   - Configure webhook endpoints
   - Set up proper SSL certificates
   - Test with real payment methods

### Step 9: Security Considerations

1. **Environment Variables**:
   ```bash
   # Never commit these to version control
   SQUARE_ACCESS_TOKEN=your_access_token
   SQUARE_WEBHOOK_SIGNATURE_KEY=your_signature_key
   ```

2. **Validate webhooks**:
   ```javascript
   const crypto = require('crypto');

   function validateWebhook(body, signature, webhookSignatureKey) {
     const hmac = crypto.createHmac('sha1', webhookSignatureKey);
     hmac.update(body);
     const hash = hmac.digest('base64');
     return hash === signature;
   }
   ```

3. **Input validation**:
   - Validate all form inputs
   - Sanitize data before storage
   - Implement rate limiting
   - Use HTTPS for all transactions

## Best Practices

1. **User Experience**:
   - Clear pricing and refund policies
   - Mobile-optimized payment flow
   - Progress indicators during payment
   - Comprehensive error messages

2. **Security**:
   - Never store card details
   - Use strong idempotency keys
   - Implement proper logging
   - Regular security audits

3. **Business**:
   - Set up proper tax handling
   - Implement refund procedures
   - Monitor payment analytics
   - Regular reconciliation

## Troubleshooting

- **Payment failures**: Check Square dashboard for details
- **JavaScript errors**: Verify Square.js is loading correctly
- **API errors**: Check access tokens and permissions
- **Mobile issues**: Test payment forms on actual devices

## Square Pricing

- **Processing fees**: 2.9% + $0.30 per transaction
- **No monthly fees** for basic processing
- **Volume discounts** available for high-volume merchants

This Square integration provides a secure, professional payment system for selling tickets directly from your Hugo site while maintaining the benefits of a static website.
