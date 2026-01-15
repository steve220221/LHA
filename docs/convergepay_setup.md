# ConvergePay Configuration

## Redirect URLs Setup

To complete the registration flow, you need to configure the redirect URLs in your ConvergePay account:

### Success URL
When payment is successful, redirect to:
```
https://lamonihistoricalassociation.org/untold-lamoni-stories/thanks/result/
```

### Cancel URL
When payment is canceled, redirect to:
```
https://lamonihistoricalassociation.org/untold-lamoni-stories/cancel/
```

## How to Configure

1. Log in to your ConvergePay merchant account
2. Navigate to the hosted payment page settings for token: `4jYHLRh9ThWl%2BXzBgg%2BxRAAAAZnu5kiW`
3. Set the "Success URL" field to the URL above
4. Set the "Cancel URL" field to the URL above
5. Save your changes

## Testing

After configuration:
1. Go to the homepage at https://lamonihistoricalassociation.org
2. Click "Register for the Event"
3. Complete a test transaction
4. Verify you're redirected to the success page
5. Test the cancel flow by canceling a payment

## Pages Now Live

- ✅ Success page: `/content/untold-lamoni-stories/thanks/result.html`
- ✅ Cancel page: `/content/untold-lamoni-stories/cancel/_index.md`
- Both pages are now set to `draft = false` and will be published
