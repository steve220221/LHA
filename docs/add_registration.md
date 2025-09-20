# Adding Formspree Registration to Hugo Site

This guide explains how to integrate Formspree with your Hugo site to collect email registrations and gauge interest for events, newsletters, or other purposes.

## What is Formspree?

Formspree is a form backend service that handles form submissions without requiring server-side code. It's perfect for static sites like Hugo because it:

- Handles form submissions via AJAX or regular POST
- Sends form data to your email
- Provides spam protection
- Offers free and paid tiers
- Works with any HTML form

## Step-by-Step Implementation

### Step 1: Set Up Formspree Account

1. **Create account**:
   - Go to [https://formspree.io](https://formspree.io)
   - Sign up with your email address
   - Verify your email

2. **Create a new form**:
   - Click "New Form" in your dashboard
   - Choose a form name (e.g., "Lamoni Registration")
   - Get your form endpoint URL (looks like `https://formspree.io/f/xbjqvprd`)

### Step 2: Create Registration Page

1. **Create the registration page**:
   ```bash
   hugo new content register.md
   ```

2. **Edit the front matter** in `content/register.md`:
   ```yaml
   +++
   title = "Register for Updates"
   date = "2025-09-19"
   draft = false
   description = "Stay informed about upcoming events and opportunities"
   layout = "register"
   +++
   ```

### Step 3: Create Custom Layout

1. **Create layout directory**:
   ```bash
   mkdir -p layouts/_default
   ```

2. **Create registration layout** at `layouts/_default/register.html`:
   ```html
   {{ define "main" }}
   <div class="registration-container">
     <div class="registration-header">
       <h1>{{ .Title }}</h1>
       <p>{{ .Description }}</p>
     </div>

     <div class="registration-form">
       <form 
         action="https://formspree.io/f/YOUR_FORM_ID" 
         method="POST"
         id="registration-form"
       >
         <!-- Name Field -->
         <div class="form-group">
           <label for="name">Full Name *</label>
           <input 
             type="text" 
             id="name" 
             name="name" 
             required
             placeholder="Enter your full name"
           >
         </div>

         <!-- Email Field -->
         <div class="form-group">
           <label for="email">Email Address *</label>
           <input 
             type="email" 
             id="email" 
             name="email" 
             required
             placeholder="your.email@example.com"
           >
         </div>

         <!-- Interest Level -->
         <div class="form-group">
           <label for="interest">Interest Level</label>
           <select id="interest" name="interest">
             <option value="">Select your interest level</option>
             <option value="very-interested">Very Interested</option>
             <option value="somewhat-interested">Somewhat Interested</option>
             <option value="just-curious">Just Curious</option>
           </select>
         </div>

         <!-- Interests Checkboxes -->
         <div class="form-group">
           <label>What interests you most? (Check all that apply)</label>
           <div class="checkbox-group">
             <label class="checkbox-label">
               <input type="checkbox" name="interests" value="workshops">
               Workshops & Sessions
             </label>
             <label class="checkbox-label">
               <input type="checkbox" name="interests" value="networking">
               Networking Opportunities
             </label>
             <label class="checkbox-label">
               <input type="checkbox" name="interests" value="speakers">
               Keynote Speakers
             </label>
             <label class="checkbox-label">
               <input type="checkbox" name="interests" value="resources">
               Resource Materials
             </label>
           </div>
         </div>

         <!-- Comments -->
         <div class="form-group">
           <label for="comments">Additional Comments or Questions</label>
           <textarea 
             id="comments" 
             name="comments" 
             rows="4"
             placeholder="Any specific topics or questions you'd like us to address?"
           ></textarea>
         </div>

         <!-- Hidden fields for better data -->
         <input type="hidden" name="_subject" value="New Registration from Lamoni Site">
         <input type="hidden" name="_next" value="{{ .Site.BaseURL }}/thank-you/">
         <input type="hidden" name="_gotcha" style="display:none">

         <!-- Submit Button -->
         <button type="submit" class="submit-btn" id="submit-btn">
           Register My Interest
         </button>
       </form>

       <!-- Success Message (hidden by default) -->
       <div id="success-message" style="display: none;" class="success-message">
         <h3>Thank You for Registering!</h3>
         <p>We've received your information and will keep you updated on upcoming events.</p>
       </div>
     </div>
   </div>
   {{ end }}
   ```

### Step 4: Add Custom CSS

1. **Create CSS file** at `assets/css/registration.css`:
   ```css
   .registration-container {
     max-width: 600px;
     margin: 0 auto;
     padding: 2rem;
   }

   .registration-header {
     text-align: center;
     margin-bottom: 2rem;
   }

   .registration-header h1 {
     color: #333;
     margin-bottom: 1rem;
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
   .form-group select,
   .form-group textarea {
     width: 100%;
     padding: 0.75rem;
     border: 1px solid #ddd;
     border-radius: 4px;
     font-size: 1rem;
     box-sizing: border-box;
   }

   .form-group input:focus,
   .form-group select:focus,
   .form-group textarea:focus {
     outline: none;
     border-color: #007cba;
     box-shadow: 0 0 0 2px rgba(0, 124, 186, 0.2);
   }

   .checkbox-group {
     display: flex;
     flex-direction: column;
     gap: 0.5rem;
   }

   .checkbox-label {
     display: flex;
     align-items: center;
     font-weight: normal;
     cursor: pointer;
   }

   .checkbox-label input[type="checkbox"] {
     width: auto;
     margin-right: 0.5rem;
   }

   .submit-btn {
     background-color: #007cba;
     color: white;
     padding: 1rem 2rem;
     border: none;
     border-radius: 4px;
     font-size: 1.1rem;
     cursor: pointer;
     width: 100%;
     transition: background-color 0.3s ease;
   }

   .submit-btn:hover {
     background-color: #005a87;
   }

   .submit-btn:disabled {
     background-color: #ccc;
     cursor: not-allowed;
   }

   .success-message {
     background-color: #d4edda;
     color: #155724;
     padding: 1rem;
     border-radius: 4px;
     border: 1px solid #c3e6cb;
     text-align: center;
   }

   .error-message {
     background-color: #f8d7da;
     color: #721c24;
     padding: 1rem;
     border-radius: 4px;
     border: 1px solid #f5c6cb;
     text-align: center;
   }

   /* Responsive design */
   @media (max-width: 768px) {
     .registration-container {
       padding: 1rem;
     }
   }
   ```

2. **Include CSS in your layout**:
   Add this to the `<head>` section of your base template or the registration layout:
   ```html
   {{ $css := resources.Get "css/registration.css" | resources.Minify }}
   <link rel="stylesheet" href="{{ $css.RelPermalink }}">
   ```

### Step 5: Add JavaScript Enhancement (Optional)

1. **Create JavaScript file** at `assets/js/registration.js`:
   ```javascript
   document.addEventListener('DOMContentLoaded', function() {
     const form = document.getElementById('registration-form');
     const submitBtn = document.getElementById('submit-btn');
     const successMessage = document.getElementById('success-message');

     if (form) {
       form.addEventListener('submit', function(e) {
         e.preventDefault();
         
         // Disable submit button
         submitBtn.disabled = true;
         submitBtn.textContent = 'Submitting...';

         // Create FormData object
         const formData = new FormData(form);

         // Submit via fetch API
         fetch(form.action, {
           method: 'POST',
           body: formData,
           headers: {
             'Accept': 'application/json'
           }
         })
         .then(response => {
           if (response.ok) {
             // Show success message
             form.style.display = 'none';
             successMessage.style.display = 'block';
           } else {
             throw new Error('Form submission failed');
           }
         })
         .catch(error => {
           // Re-enable button on error
           submitBtn.disabled = false;
           submitBtn.textContent = 'Register My Interest';
           alert('Sorry, there was an error submitting your registration. Please try again.');
         });
       });
     }
   });
   ```

2. **Include JavaScript in layout**:
   ```html
   {{ $js := resources.Get "js/registration.js" | resources.Minify }}
   <script src="{{ $js.RelPermalink }}"></script>
   ```

### Step 6: Create Thank You Page

1. **Create thank you page**:
   ```bash
   hugo new content thank-you.md
   ```

2. **Edit content/thank-you.md**:
   ```yaml
   +++
   title = "Thank You for Registering!"
   date = "2025-09-19"
   draft = false
   description = "Registration confirmation"
   +++

   ## Thank You!

   We've received your registration and will keep you updated on upcoming events and opportunities.

   ### What's Next?

   - You'll receive a confirmation email shortly
   - We'll send updates about upcoming events
   - Look out for exclusive early-bird offers

   [Return to Home](/) or [Learn More About Our Events](/posts/)
   ```

### Step 7: Configure Formspree Form Settings

1. **Update form endpoint**:
   - Replace `YOUR_FORM_ID` in the form action with your actual Formspree form ID

2. **Configure Formspree settings** (in Formspree dashboard):
   - **Notifications**: Set your email for form submissions
   - **Spam Protection**: Enable reCAPTCHA if desired
   - **Redirects**: Set redirect URL to your thank-you page
   - **Webhooks**: Configure if you need data sent elsewhere

### Step 8: Add Navigation Link

1. **Update site navigation** in `hugo.toml`:
   ```toml
   [menu]
     [[menu.main]]
       name = "Register"
       url = "/register/"
       weight = 30
   ```

### Step 9: Test the Form

1. **Start development server**:
   ```bash
   make dev
   ```

2. **Test the form**:
   - Navigate to `/register/`
   - Fill out the form with test data
   - Submit and verify you receive the email
   - Check that redirect works properly

### Advanced Features

#### A. Add Email Validation
```javascript
function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}
```

#### B. Add Progress Indicators
```css
.form-progress {
  width: 100%;
  background-color: #f0f0f0;
  border-radius: 10px;
  margin-bottom: 1rem;
}

.form-progress-bar {
  height: 8px;
  background-color: #007cba;
  border-radius: 10px;
  transition: width 0.3s ease;
}
```

#### C. Add Conditional Fields
```javascript
document.getElementById('interest').addEventListener('change', function() {
  const conditionalFields = document.getElementById('conditional-fields');
  if (this.value === 'very-interested') {
    conditionalFields.style.display = 'block';
  } else {
    conditionalFields.style.display = 'none';
  }
});
```

## Best Practices

1. **Keep forms simple**: Only ask for essential information
2. **Mobile-first design**: Ensure forms work well on all devices
3. **Clear labels**: Use descriptive, helpful labels
4. **Error handling**: Provide clear error messages
5. **Privacy**: Include privacy policy link
6. **Accessibility**: Use proper ARIA labels and semantic HTML
7. **Testing**: Test on multiple browsers and devices

## Troubleshooting

- **Form not submitting**: Check Formspree endpoint URL
- **Not receiving emails**: Check spam folder and Formspree notifications settings
- **Styling issues**: Verify CSS file is being loaded
- **JavaScript errors**: Check browser console for errors
- **Mobile issues**: Test responsive design on actual devices

## Formspree Pricing

- **Free tier**: 50 submissions/month
- **Paid tiers**: Start at $10/month for more submissions and features
- **Enterprise**: Custom pricing for high-volume needs

This registration system will help you collect and manage interest in your events effectively while maintaining a professional appearance on your Hugo site.
