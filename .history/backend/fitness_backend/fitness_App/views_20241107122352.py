from django.http import JsonResponse
from django.views import View
from django.core.mail import send_mail
from twilio.rest import Client
import random

class SendCodeView(View):
    def post(self, request):
        method = request.POST.get('method')
        user_contact = request.POST.get('email')  # This can be email or phone number
        verification_code = random.randint(100000, 999999)

        if method == 'email':
            send_mail(
                'Your Verification Code',
                f'Your verification code is {verification_code}',
                'from@example.com',
                [user_contact],
                fail_silently=False,
            )
        elif method == 'phone':
            client = Client('TWILIO_ACCOUNT_SID', 'TWILIO_AUTH_TOKEN')
            client.messages.create(
                body=f'Your verification code is {verification_code}',
                from_='+1234567890',  # Your Twilio number
                to=user_contact
            )

        # Store the verification code in the session or database for later verification
        request.session['verification_code'] = verification_code
        return JsonResponse({'status': 'success'})

class VerifyCodeView(View):
    def post(self, request):
        verification_code = request.POST.get('verification_code')
        stored_code = request.session.get('verification_code')

        if str(verification_code) == str(stored_code):
            return JsonResponse({'status': 'success'})
        else:
            return JsonResponse({'status': 'error', 'message': 'Invalid verification code'})