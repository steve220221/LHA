+++
date = '2025-10-11T02:45:18-05:00'

title = 'Stories'
+++
<form id="uls-reg" action="https://formspree.io/f/REPLACE_FORM_ID" method="POST">
  <input type="hidden" name="_subject" value="Untold Lamoni Stories — Registration" />
  <p><label>Full Name <input name="full_name" required></label></p>
  <p><label>Email <input type="email" name="email" required></label></p>
  <p><label>Phone <input name="phone"></label></p>
  <p><label>Ticket Qty <select name="ticket_qty" required>
    <option>1</option><option>2</option><option>3</option><option>4</option>
  </select></label></p>
  <p><label>Dietary Restrictions <input name="dietary"></label></p>
  <p><label>Days Attending <select name="days" required>
    <option>Friday</option><option>Saturday</option><option>Both</option>
  </select></label></p>
  <p><label>Meals Included? <select name="meals" required>
    <option>Yes</option><option>No</option>
  </select></label></p>
  <button type="submit">Submit Registration</button>
</form>
<div id="reg-success" style="display:none;">
  <p><strong>Thanks!</strong> Your registration was sent.</p>
  <p><a class="paybtn" href="/untold-lamoni-stories/pay/">Proceed to Payment</a></p>
</div>
<script>
const form=document.getElementById('uls-reg');
form.addEventListener('submit',async(e)=>{e.preventDefault();
await fetch(form.action,{method:'POST',body:new FormData(form),headers:{'Accept':'application/json'}});
document.getElementById('reg-success').style.display='block'; form.style.display='none';});
</script>
