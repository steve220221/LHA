# Creating a Symposium Section on Hugo Site

This guide explains how to create a dedicated symposium section on your Hugo site where visitors can find event information, register to attend, view schedules, and access all event-related content.

## Overview

A symposium section provides a centralized hub for event information including:

- Event overview and description
- Schedule and agenda
- Speaker information
- Registration functionality
- Venue details
- Accommodation suggestions
- FAQ section
- Contact information

## Step-by-Step Implementation

### Step 1: Create Symposium Content Structure

1. **Create symposium section directory**:
   ```bash
   mkdir -p content/symposium
   ```

2. **Create section index page**:
   ```bash
   hugo new content symposium/_index.md
   ```

3. **Edit the symposium index** in `content/symposium/_index.md`:
   ```yaml
   +++
   title = "Annual Symposium 2025"
   date = "2025-09-19"
   draft = false
   description = "Join us for our annual symposium featuring leading experts and innovative ideas"
   layout = "symposium-home"
   type = "symposium"
   
   [params]
     event_date = "2025-10-15"
     event_time = "9:00 AM - 5:00 PM"
   event_location = "Convention Center, Downtown"
     registration_open = true
     early_bird_deadline = "2025-09-30"
     regular_price = "$150"
     early_bird_price = "$120"
   +++

   # Welcome to the Annual Symposium 2025

   Join leading experts, innovators, and thought leaders for a day of inspiring presentations, networking opportunities, and collaborative discussions that will shape the future of our field.

   ## Event Highlights

   - **Keynote Speakers**: Renowned experts sharing cutting-edge insights
   - **Workshop Sessions**: Hands-on learning opportunities
   - **Networking Lunch**: Connect with peers and industry leaders
   - **Panel Discussions**: Interactive Q&A with experts
   - **Exhibition Area**: Latest tools and resources on display

   ## Why Attend?

   - Gain insights from industry leaders
   - Network with like-minded professionals
   - Discover new tools and methodologies
   - Earn continuing education credits
   - Access exclusive resources and materials
   ```

### Step 2: Create Symposium Pages

1. **Create individual pages**:
   ```bash
   hugo new content symposium/schedule.md
   hugo new content symposium/speakers.md
   hugo new content symposium/venue.md
   hugo new content symposium/registration.md
   hugo new content symposium/faq.md
   ```

2. **Edit schedule page** (`content/symposium/schedule.md`):
   ```yaml
   +++
   title = "Event Schedule"
   date = "2025-09-19"
   draft = false
   description = "Detailed schedule for the Annual Symposium 2025"
   type = "symposium"
   layout = "schedule"
   weight = 10
   +++

   # Symposium Schedule

   ## Day Overview
   **Date**: October 15, 2025  
   **Time**: 9:00 AM - 5:00 PM  
   **Location**: Convention Center, Downtown

   ---

   ## Morning Sessions

   ### 9:00 - 9:30 AM: Registration & Welcome Coffee
   - Check-in and badge pickup
   - Welcome coffee and networking
   - **Location**: Main Lobby

   ### 9:30 - 10:30 AM: Opening Keynote
   **Speaker**: Dr. Jane Smith  
   **Topic**: "The Future of Innovation"  
   **Location**: Main Auditorium

   ### 10:30 - 10:45 AM: Break

   ### 10:45 - 12:00 PM: Concurrent Sessions A

   #### Session A1: Technology Trends
   **Speaker**: John Doe  
   **Location**: Room 101

   #### Session A2: Leadership Strategies
   **Speaker**: Sarah Johnson  
   **Location**: Room 102

   #### Session A3: Hands-on Workshop
   **Facilitator**: Mike Wilson  
   **Location**: Workshop Room A

   ---

   ## Afternoon Sessions

   ### 12:00 - 1:00 PM: Networking Lunch
   **Location**: Exhibition Hall

   ### 1:00 - 2:15 PM: Concurrent Sessions B

   #### Session B1: Industry Panel
   **Moderator**: Lisa Chen  
   **Panelists**: Multiple industry experts  
   **Location**: Main Auditorium

   #### Session B2: Case Studies
   **Speaker**: Robert Brown  
   **Location**: Room 101

   ### 2:15 - 2:30 PM: Break

   ### 2:30 - 3:45 PM: Concurrent Sessions C

   #### Session C1: Future Outlook
   **Speaker**: Amanda Davis  
   **Location**: Room 102

   #### Session C2: Interactive Workshop
   **Facilitator**: David Kim  
   **Location**: Workshop Room B

   ### 4:00 - 5:00 PM: Closing Keynote & Wrap-up
   **Speaker**: Prof. Michael Thompson  
   **Topic**: "Looking Ahead: Challenges and Opportunities"  
   **Location**: Main Auditorium
   ```

3. **Edit speakers page** (`content/symposium/speakers.md`):
   ```yaml
   +++
   title = "Featured Speakers"
   date = "2025-09-19"
   draft = false
   description = "Meet our distinguished speakers for the Annual Symposium 2025"
   type = "symposium"
   layout = "speakers"
   weight = 20
   +++

   # Featured Speakers

   ## Keynote Speakers

   ### Dr. Jane Smith
   **Opening Keynote: "The Future of Innovation"**

   Dr. Jane Smith is a renowned expert in technological innovation with over 20 years of experience leading breakthrough projects at Fortune 500 companies. She holds a PhD in Computer Science from MIT and has authored three bestselling books on innovation strategy.

   **Bio**: Former CTO at TechCorp, current Professor at Stanford University  
   **Expertise**: AI, Machine Learning, Innovation Strategy  
   **Notable Achievements**: 
   - Named "Innovator of the Year" by Tech Magazine (2024)
   - Holder of 15 patents in AI technology
   - Keynote speaker at major tech conferences worldwide

   ---

   ### Prof. Michael Thompson
   **Closing Keynote: "Looking Ahead: Challenges and Opportunities"**

   Professor Thompson brings decades of research experience and practical insights into emerging technologies and their societal impact. His work has been published in over 100 peer-reviewed journals.

   **Bio**: Department Head, Future Studies Institute  
   **Expertise**: Emerging Technologies, Social Impact, Future Trends  
   **Notable Achievements**:
   - Author of "Technology and Society: The Next Decade"
   - Advisor to government technology policy committees
   - Recipient of the Excellence in Research Award

   ## Session Speakers

   ### John Doe - Technology Trends Specialist
   Leading expert in identifying and analyzing emerging technology trends with 15 years of industry experience.

   ### Sarah Johnson - Leadership Consultant
   Executive coach and leadership development specialist working with C-suite executives across multiple industries.

   ### Mike Wilson - Workshop Facilitator
   Hands-on practitioner specializing in interactive learning experiences and skill development workshops.

   ### Lisa Chen - Industry Analyst
   Senior analyst covering technology markets with deep expertise in industry dynamics and competitive landscapes.

   ### Robert Brown - Case Study Expert
   Management consultant with extensive experience in documenting and presenting real-world business transformations.

   ### Amanda Davis - Futurist
   Strategic foresight consultant helping organizations prepare for future challenges and opportunities.

   ### David Kim - Innovation Coach
   Practical innovation specialist working with teams to develop creative problem-solving capabilities.
   ```

### Step 3: Create Custom Layouts

1. **Create symposium layouts directory**:
   ```bash
   mkdir -p layouts/symposium
   ```

2. **Create symposium home layout** (`layouts/symposium/symposium-home.html`):
   ```html
   {{ define "main" }}
   <div class="symposium-hero">
     <div class="hero-content">
       <h1>{{ .Title }}</h1>
       <p class="hero-subtitle">{{ .Description }}</p>
       <div class="event-details">
         <div class="detail-item">
           <strong>📅 Date:</strong> {{ .Params.event_date | dateFormat "January 2, 2006" }}
         </div>
         <div class="detail-item">
           <strong>🕘 Time:</strong> {{ .Params.event_time }}
         </div>
         <div class="detail-item">
           <strong>📍 Location:</strong> {{ .Params.event_location }}
         </div>
       </div>
       
       {{ if .Params.registration_open }}
       <div class="cta-buttons">
         <a href="/symposium/registration/" class="btn btn-primary">Register Now</a>
         <a href="/symposium/schedule/" class="btn btn-secondary">View Schedule</a>
       </div>
       
       <div class="pricing-info">
         <p><strong>Early Bird:</strong> {{ .Params.early_bird_price }} (until {{ .Params.early_bird_deadline | dateFormat "Jan 2" }})</p>
         <p><strong>Regular:</strong> {{ .Params.regular_price }}</p>
       </div>
       {{ end }}
     </div>
   </div>

   <div class="symposium-content">
     <div class="container">
       {{ .Content }}
       
       <div class="symposium-sections">
         <div class="section-grid">
           <div class="section-card">
             <h3>📋 Schedule</h3>
             <p>View the detailed event schedule, session times, and speaker lineup.</p>
             <a href="/symposium/schedule/" class="card-link">View Schedule →</a>
           </div>
           
           <div class="section-card">
             <h3>🎤 Speakers</h3>
             <p>Meet our distinguished speakers and learn about their expertise.</p>
             <a href="/symposium/speakers/" class="card-link">Meet Speakers →</a>
           </div>
           
           <div class="section-card">
             <h3>📍 Venue</h3>
             <p>Get directions, parking information, and accommodation suggestions.</p>
             <a href="/symposium/venue/" class="card-link">Venue Info →</a>
           </div>
           
           <div class="section-card">
             <h3>❓ FAQ</h3>
             <p>Find answers to frequently asked questions about the event.</p>
             <a href="/symposium/faq/" class="card-link">Read FAQ →</a>
           </div>
         </div>
       </div>
     </div>
   </div>
   {{ end }}
   ```

3. **Create schedule layout** (`layouts/symposium/schedule.html`):
   ```html
   {{ define "main" }}
   <div class="symposium-page">
     <div class="container">
       <nav class="symposium-nav">
         <a href="/symposium/">← Back to Symposium</a>
       </nav>
       
       <div class="schedule-header">
         <h1>{{ .Title }}</h1>
         <div class="download-options">
           <a href="/files/symposium-schedule.pdf" class="btn btn-outline" download>
             📥 Download PDF Schedule
           </a>
           <a href="/files/symposium-calendar.ics" class="btn btn-outline" download>
             📅 Add to Calendar
           </a>
         </div>
       </div>
       
       <div class="schedule-content">
         {{ .Content }}
       </div>
       
       <div class="schedule-actions">
         <a href="/symposium/registration/" class="btn btn-primary">Register for Event</a>
         <a href="/symposium/speakers/" class="btn btn-secondary">Meet the Speakers</a>
       </div>
     </div>
   </div>
   {{ end }}
   ```

4. **Create speakers layout** (`layouts/symposium/speakers.html`):
   ```html
   {{ define "main" }}
   <div class="symposium-page">
     <div class="container">
       <nav class="symposium-nav">
         <a href="/symposium/">← Back to Symposium</a>
       </nav>
       
       <div class="speakers-header">
         <h1>{{ .Title }}</h1>
         <p>{{ .Description }}</p>
       </div>
       
       <div class="speakers-content">
         {{ .Content }}
       </div>
       
       <div class="speakers-actions">
         <a href="/symposium/registration/" class="btn btn-primary">Register to Meet Them</a>
         <a href="/symposium/schedule/" class="btn btn-secondary">View Their Sessions</a>
       </div>
     </div>
   </div>
   {{ end }}
   ```

### Step 4: Add Symposium Styles

1. **Create symposium CSS** (`assets/css/symposium.css`):
   ```css
   /* Symposium Specific Styles */
   .symposium-hero {
     background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
     color: white;
     padding: 4rem 0;
     text-align: center;
   }

   .hero-content {
     max-width: 800px;
     margin: 0 auto;
     padding: 0 2rem;
   }

   .hero-content h1 {
     font-size: 3rem;
     margin-bottom: 1rem;
     font-weight: bold;
   }

   .hero-subtitle {
     font-size: 1.3rem;
     margin-bottom: 2rem;
     opacity: 0.9;
   }

   .event-details {
     display: flex;
     justify-content: center;
     gap: 2rem;
     margin-bottom: 2rem;
     flex-wrap: wrap;
   }

   .detail-item {
     background: rgba(255, 255, 255, 0.1);
     padding: 1rem;
     border-radius: 8px;
     backdrop-filter: blur(10px);
   }

   .cta-buttons {
     display: flex;
     gap: 1rem;
     justify-content: center;
     margin-bottom: 2rem;
     flex-wrap: wrap;
   }

   .btn {
     padding: 1rem 2rem;
     border-radius: 8px;
     text-decoration: none;
     font-weight: bold;
     transition: all 0.3s ease;
     display: inline-block;
     border: 2px solid transparent;
   }

   .btn-primary {
     background-color: #ff6b6b;
     color: white;
   }

   .btn-primary:hover {
     background-color: #ee5a52;
     transform: translateY(-2px);
   }

   .btn-secondary {
     background-color: transparent;
     color: white;
     border-color: white;
   }

   .btn-secondary:hover {
     background-color: white;
     color: #667eea;
   }

   .btn-outline {
     background-color: transparent;
     color: #333;
     border-color: #333;
   }

   .btn-outline:hover {
     background-color: #333;
     color: white;
   }

   .pricing-info {
     font-size: 1.1rem;
     opacity: 0.9;
   }

   .pricing-info p {
     margin: 0.5rem 0;
   }

   /* Symposium Content */
   .symposium-content {
     padding: 4rem 0;
   }

   .container {
     max-width: 1200px;
     margin: 0 auto;
     padding: 0 2rem;
   }

   .section-grid {
     display: grid;
     grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
     gap: 2rem;
     margin-top: 3rem;
   }

   .section-card {
     background: white;
     padding: 2rem;
     border-radius: 12px;
     box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
     transition: transform 0.3s ease, box-shadow 0.3s ease;
   }

   .section-card:hover {
     transform: translateY(-5px);
     box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
   }

   .section-card h3 {
     color: #333;
     margin-bottom: 1rem;
     font-size: 1.3rem;
   }

   .section-card p {
     color: #666;
     margin-bottom: 1.5rem;
     line-height: 1.6;
   }

   .card-link {
     color: #667eea;
     text-decoration: none;
     font-weight: bold;
     transition: color 0.3s ease;
   }

   .card-link:hover {
     color: #764ba2;
   }

   /* Symposium Pages */
   .symposium-page {
     padding: 2rem 0 4rem;
   }

   .symposium-nav {
     margin-bottom: 2rem;
   }

   .symposium-nav a {
     color: #667eea;
     text-decoration: none;
     font-weight: bold;
   }

   .symposium-nav a:hover {
     text-decoration: underline;
   }

   .schedule-header,
   .speakers-header {
     text-align: center;
     margin-bottom: 3rem;
   }

   .download-options {
     display: flex;
     gap: 1rem;
     justify-content: center;
     margin-top: 1rem;
     flex-wrap: wrap;
   }

   .schedule-content,
   .speakers-content {
     margin-bottom: 3rem;
   }

   .schedule-actions,
   .speakers-actions {
     text-align: center;
     padding-top: 2rem;
     border-top: 1px solid #eee;
   }

   .schedule-actions .btn,
   .speakers-actions .btn {
     margin: 0 0.5rem;
   }

   /* Responsive Design */
   @media (max-width: 768px) {
     .hero-content h1 {
       font-size: 2rem;
     }

     .hero-subtitle {
       font-size: 1.1rem;
     }

     .event-details {
       flex-direction: column;
       gap: 1rem;
     }

     .cta-buttons {
       flex-direction: column;
       align-items: center;
     }

     .btn {
       width: 100%;
       max-width: 300px;
     }

     .download-options {
       flex-direction: column;
       align-items: center;
     }
   }

   /* Schedule Specific Styles */
   .schedule-content h2 {
     color: #667eea;
     border-bottom: 2px solid #667eea;
     padding-bottom: 0.5rem;
     margin-top: 2rem;
   }

   .schedule-content h3 {
     color: #333;
     margin-top: 1.5rem;
   }

   .schedule-content h4 {
     color: #666;
     font-size: 1.1rem;
     margin-top: 1rem;
   }

   .schedule-content hr {
     border: none;
     border-top: 1px solid #eee;
     margin: 2rem 0;
   }

   /* Speaker Specific Styles */
   .speakers-content h2 {
     color: #667eea;
     border-bottom: 2px solid #667eea;
     padding-bottom: 0.5rem;
   }

   .speakers-content h3 {
     color: #333;
     margin-top: 2rem;
   }

   .speakers-content strong {
     color: #667eea;
   }
   ```

### Step 5: Create Symposium Navigation

1. **Update main navigation** in `hugo.toml`:
   ```toml
   [menu]
     [[menu.main]]
       name = "Symposium"
       url = "/symposium/"
       weight = 25
   ```

2. **Create symposium submenu** in symposium layout:
   ```html
   <nav class="symposium-subnav">
     <ul>
       <li><a href="/symposium/">Overview</a></li>
       <li><a href="/symposium/schedule/">Schedule</a></li>
       <li><a href="/symposium/speakers/">Speakers</a></li>
       <li><a href="/symposium/venue/">Venue</a></li>
       <li><a href="/symposium/registration/">Register</a></li>
       <li><a href="/symposium/faq/">FAQ</a></li>
     </ul>
   </nav>
   ```

### Step 6: Integration with Registration

1. **Link to registration form** created in previous documentation:
   ```html
   <div class="registration-integration">
     <h2>Ready to Register?</h2>
     <p>Secure your spot at the symposium today!</p>
     <a href="/register/" class="btn btn-primary btn-large">
       Register Now - Early Bird Special!
     </a>
   </div>
   ```

2. **Add symposium-specific fields** to registration form:
   ```html
   <!-- Add to registration form -->
   <div class="form-group">
     <label for="event">Which event are you registering for?</label>
     <select id="event" name="event" required>
       <option value="">Select an event</option>
       <option value="symposium-2025">Annual Symposium 2025</option>
       <option value="workshop-series">Workshop Series</option>
       <option value="networking-events">Networking Events</option>
     </select>
   </div>

   <div class="form-group">
     <label for="ticket-type">Ticket Type</label>
     <select id="ticket-type" name="ticket_type" required>
       <option value="">Select ticket type</option>
       <option value="early-bird">Early Bird - $120</option>
       <option value="regular">Regular - $150</option>
       <option value="student">Student - $75</option>
       <option value="group">Group (5+) - Contact for pricing</option>
     </select>
   </div>
   ```

### Step 7: Add Supporting Files

1. **Create downloadable schedule PDF**:
   ```bash
   mkdir -p static/files
   # Add symposium-schedule.pdf to static/files/
   ```

2. **Create calendar file** (`static/files/symposium-calendar.ics`):
   ```ics
   BEGIN:VCALENDAR
   VERSION:2.0
   PRODID:-//Lamoni//Annual Symposium//EN
   BEGIN:VEVENT
   UID:symposium2025@lamoni.com
   DTSTAMP:20250919T000000Z
   DTSTART:20251015T150000Z
   DTEND:20251015T230000Z
   SUMMARY:Annual Symposium 2025
   DESCRIPTION:Join leading experts for a day of inspiring presentations and networking
   LOCATION:Convention Center, Downtown
   END:VEVENT
   END:VCALENDAR
   ```

### Step 8: SEO and Social Media

1. **Add schema markup** for events:
   ```html
   <script type="application/ld+json">
   {
     "@context": "https://schema.org",
     "@type": "Event",
     "name": "{{ .Title }}",
     "description": "{{ .Description }}",
     "startDate": "{{ .Params.event_date }}",
     "location": {
       "@type": "Place",
       "name": "{{ .Params.event_location }}"
     },
     "offers": {
       "@type": "Offer",
       "price": "{{ .Params.regular_price }}",
       "priceCurrency": "USD"
     }
   }
   </script>
   ```

2. **Add social media meta tags**:
   ```html
   <meta property="og:title" content="{{ .Title }}">
   <meta property="og:description" content="{{ .Description }}">
   <meta property="og:type" content="event">
   <meta property="og:url" content="{{ .Permalink }}">
   ```

### Step 9: Test the Symposium Section

1. **Start development server**:
   ```bash
   make dev
   ```

2. **Test all pages**:
   - Visit `/symposium/` for overview
   - Check `/symposium/schedule/` for event timeline
   - Review `/symposium/speakers/` for speaker information
   - Verify navigation between pages
   - Test responsive design on mobile

3. **Validate**:
   - Check all links work correctly
   - Ensure styles load properly
   - Verify content displays correctly
   - Test registration integration

## Best Practices

1. **Content Management**: Keep event information updated regularly
2. **Mobile Optimization**: Ensure all symposium pages work well on mobile devices
3. **Accessibility**: Use proper heading hierarchy and alt text for images
4. **Performance**: Optimize images and minimize CSS/JS
5. **SEO**: Include relevant keywords and meta descriptions
6. **User Experience**: Provide clear navigation and calls-to-action

## Maintenance Tips

1. **Regular Updates**: Keep speaker bios and schedule current
2. **Registration Monitoring**: Track registration numbers and adjust as needed
3. **Content Backup**: Maintain backups of all symposium content
4. **Analytics**: Monitor page visits and user engagement
5. **Feedback Collection**: Gather feedback for future improvements

This symposium section provides a professional, informative hub for your event that integrates seamlessly with your Hugo site and registration system.
