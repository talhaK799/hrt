import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50, left: 25),
      child: Column(
        children: [
          ///
          /// AppBar
          ///

          CustomAppBar(
            title: "Terms And Conditions",
          ),

          ///
          /// Body
          ///
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Html(
                  data: """
                <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HART - Terms of Use and Community Rules</title>
    <!-- Add your CSS link or styles here -->
</head>
<body>

    <header>
        <h1>TERMS OF USE AND COMMUNITY RULES</h1>
        <p>Last Updated: 14/11/2023</p>
    </header>

    <section>
        <h2>Introduction</h2>
        <ol>
            <li>Welcome to Hard, a [dating app for the curious].</li>
            <li>These terms of use (the “Terms”) tell you the terms on which you may use the Hart website at <a href="https://hart.co/" target="_blank">https://hart.co/</a> (the “Site”), the Hart app (the “App”) and the products, services and content available from them. They also apply to any purchases you make on our Site or App. In these Terms we refer collectively to the Site, the App and the content, products and services available from them as Hart.</li>
            <li>YOUR ATTENTION IS PARTICULARLY DRAWN TO PARAGRAPHS:
                <ul>
                    <li>THE AUTO-RENEWAL TERMS FOR SUBSCRIPTIONS (PARAGRAPH 9.6)</li>
                    <li>YOUR RIGHT TO CANCEL HART OR A PURCHASE DURING THE COOLING-OFF PERIOD (PARAGRAPH 10)</li>
                    <li>OUR COMMUNITY RULES (PARAGRAPH 12)</li>
                    <li>OUR RIGHT TO MAKE CHANGES TO HART AND TO STOP PROVIDING IT (PARAGRAPHS 15 AND 16)</li>
                    <li>OUR RIGHTS TO RESTRICT OR STOP YOUR ACCESS TO HART (PARAGRAPHS 17 AND 18)</li>
                    <li>Our Responsibility to You (PARAGRAPH 24).</li>
                </ul>
            </li>
        </ol>
    </section>

    <section>
        <h2>About Us</h2>
        <ol>
            <li>These Terms should be read alongside our Privacy Policy.</li>
            <li>There will also be other terms or rules that apply to your use of a particular product or service on Hart, which we will let you know about before you purchase or use the relevant product or service. These additional terms will form part of these Terms, unless they are third party terms which create a direct contract between you and a third party.</li>
        </ol>
    </section>

    <section>
        <h2>About Us</h2>
        <ol>
            <li>Hart is provided to you by Hart Limited (“us”, “we”, or “our”). We are registered in England and Wales under company number 08916634 and with our registered office at Hikenield House, East Anton Court, Icknield Way, Andover, Hampshire SP10 5RG United Kingdom.</li>
            <li>Our VAT number is GB 213601359.</li>
        </ol>
    </section>

    <!-- Continue adding more sections with appropriate headings and content -->
        <section>
        <h2>How to Contact Us</h2>
        <ol>
            <li>Our email address is <a href="mailto:support@hart.co">support@hart.co</a></li>
            <li>Our postal address for correspondence is Hart Limited, 86-90 Paul Street, London, EC2A 4NE, United Kingdom.</li>
            <li>Please contact us using the above contact details if you have a question or complaint about Hart, including any of its content. We will try to answer your inquiry or resolve any complaint as soon as possible within a few days of your submission. If your issue was not resolved, or if you would like to appeal the decision, please contact <a href="mailto:legal@hart.co">legal@hart.co</a>.</li>
            <li>Please also contact us if you have any suggestions for improvements or additions that you would like to see on Hart.</li>
        </ol>
    </section>

    <section>
        <h2>How We Will Contact You</h2>
        <ol>
            <li>We will mainly contact you by email. We may also contact you by post.</li>
            <li>We will use the email and postal address provided when creating your account. As such, you must notify us as soon as possible if any of your details change.</li>
        </ol>
    </section>

    <section>
        <h2>These Terms of Use</h2>
        <ol>
            <li>Please read these Terms carefully before you start to use Hart. By using Hart in any way, you confirm that you accept these Terms and that you agree to comply with them. If you do not agree to these Terms, you must not use Hart. You might want to print a copy for your own records.</li>
            <li>These Terms will always be available on our website. It’s important that you regularly check this page to see if any changes have been made and that you review the Terms whenever we update them or you use Hart.</li>
        </ol>
    </section>

    <!-- Continue adding more sections with appropriate headings and content -->

    <section>
        <h2>Changes to These Terms of Use</h2>
        <ol>
            <li>We may make changes to these Terms from time to time without asking for your express consent. We will give you at least 30 days' notice through one of our usual channels detailed in paragraph 4 above before the change takes effect. Although, if you have a paid subscription to Hart, any changes will only become effective when your current subscription period ends (which is usually the date of your next payment following the change).</li>
            <li>If you do not agree with any changes that we make to these Terms, you can let us know, and we will close your account in accordance with paragraph 19 below.</li>
            <li>If you continue to use Hart following any change to these Terms, you will be accepting and agreeing to the changes. If you do not agree to them, you should not use Hart.</li>
        </ol>
    </section>

    <section>
        <h2>Conditions of ACCESS TO HART</h2>
        <ol>
            <li>To use Hart:
                <ul>
                    <li>You must be aged 18 years old or over and confirm this by providing your date of birth during registration.</li>
                    <li>You must not be barred from using Hart either by us previously or under the laws of the country where you live, or any other laws that apply to your use of Hart.</li>
                    <li>You must register as a member of Hart by creating an account (an “Account”).</li>
                </ul>
            </li>
            <li>You may only access Hart for individual, personal, and non-commercial use.</li>
            <li>Your access to Hart and any information, messages, articles, blogs, music, videos, images, photographs, and other content displayed on Hart (together, “Content”) is permitted in accordance with, and subject to your compliance with, these Terms and in particular our Community Rules at paragraph 12 below.</li>
            <li>Please note that the use of Hart is subject to your computer and/or device complying with our minimum standard technical specifications and compatibility requirements which are available <a href="[link to specifications]">here</a>.</li>
            <li>You are responsible for making all arrangements necessary for you to access Hart.</li>
        </ol>
    </section>

    <!-- Continue adding more sections with appropriate headings and content -->

    <section>
        <h2>Creating an Account</h2>
        <ol>
            <li>You can create an Account through your email address and phone number, your social media account with Facebook, or your Apple ID account. If you choose to use a third-party account like Facebook, we will access personal information about you from the third-party provider, such as your email address, name, and date of birth. Further information about the use of third-party accounts is provided in our <a href="[link to Privacy Policy]">Privacy Policy</a>.</li>
            <li>If using email to create an Account:
                <ul>
                    <li>You must be the sole owner and operator of the email you provide.</li>
                    <li>You must be the sole owner and operator of the mobile number you provide and prove it with verification.</li>
                </ul>
            </li>
            <li>If using a third-party account to create or verify an Account:
                <ul>
                    <li>The third party must have verified that you are aged 18 years old or over.</li>
                    <li>You must be the only user of your third-party account.</li>
                    <li>You must have provided correct, current, and complete information about yourself when initially opening the third-party account.</li>
                </ul>
            </li>
            <li>For additional security, you are given the option to lock the device with TouchID and/or a Passcode through your device settings.</li>
            <li>You must provide us with accurate, complete, and up-to-date information when opening your Account, and you agree to update such information to keep it that way. If you don’t, we may suspend or terminate your Account.</li>
            <li>You will be responsible for any use of Hart through your Account. You agree that you will not disclose your Account password to anyone and will notify us immediately of any unauthorized use of your Account. If you believe that your Account is no longer secure, then you must immediately notify us at <a href="mailto:support@hart.co">support@hart.co</a>.</li>
            <li>You may not create an Account for anyone else or create an Account in a name other than your own.</li>
        </ol>
    </section>

    <section>
        <h2>Purchases</h2>
        <ol>
            <li>We may make products and services such as Pings (which lets you ping other users) and Uplifts (which provide more visibility) available through Hart for a fee (a Hart Product”). They may be available as a one-off purchase or on a subscription basis.</li>
            <li>Order process: To make a purchase, you must click on the [Purchase] button via the app to place an order. Confirmation that your order has been successfully submitted does not mean that your order has been accepted by us. Your order is an offer to buy the Hart Product on these Terms. Acceptance of your order by us takes place when we send you an order confirmation email, at which point a legally binding contract for the purchase is formed between you and us on these Terms.</li>
            <li>Rejecting your order: If we do not accept your order (e.g., because we have been unable to take payment, the Hart Product is unavailable, you are under 18, or there has been a mistake regarding the pricing or description of the Hart Product), we will email you and provide you with a refund if payment has already been taken. We have the right to reject any order for any reason.</li>
            <li>Prices: Prices for Hart Products will be set out on our Site and App. All prices are in pounds sterling for members in the United Kingdom and Euros for members in the European Union. They also include VAT at the applicable rate. Prices may change at any time. Such changes will not affect existing orders unless there is a pricing error (see paragraph above).</li>
            <li>Payment: All payments will be made through the app. Please refer to Google Play Store and the (Apple) App Store for requirements.</li>
            <li>Your Subscription will automatically renew each month. If you purchase a subscription, you will be charged the subscription fee stated on the Site or App on the start date of your subscription. On each anniversary of the start date, your subscription will automatically renew for a further one-month period, and you will be charged a further subscription fee on or around that date.</li>
            <li>By purchasing a subscription, you authorize us to take recurring payments from your card. Your subscription continues until canceled by you or we terminate your access to or use of Hart or your subscription in accordance with these Terms. We will remind you that your subscription is coming up for renewal on or around 3 days before the renewal date. The reminder will also contain details of the price payable for the renewal. You will then have until the date of your renewal to cancel your subscription to stop it renewing.</li>
            <li>Cancelling a subscription: You may cancel your subscription at any time, but please note that cancellation will only take effect at the end of the then-current subscription period, and you will receive a refund for the subscription fee paid for that period for the unused amount of the subscription. To cancel, you can send an email to <a href="mailto:support@hart.co">support@hart.co</a>, and you also must cancel your subscription in the settings of the App.</li>
        </ol>
    </section>

    <section>
        <h2>Your right to cancel HART OR a purchase during the cooling-off period</h2>
        <ol>
            <li>Except in the circumstances listed in the next paragraph, you have the right to change your mind and cancel your Hart Product order (or your Hart Membership) within 14 days from the date of your order confirmation or account opening email.</li>
            <li>You can't change your mind about an order for services such as Pings or Uplifts once these have been completed.</li>
            <li>We will not open your Account or provide any Hart Products that are services during the 14-day cancellation period unless you request for us to do so by ticking the relevant box when you open your Account or place your order. We are under no obligation to accept your request.</li>
            <li>To cancel your order, please email us at <a href="mailto:support@hart.co">support@hart.co</a>. You can also use the cancellation form available here [link to model cancellation form]. To help us process your cancellation more quickly, please include your order number in the email or cancellation form you send to us.</li>
            <li>You have to pay for services you received before you change your mind. If you bought a Subscription, we don’t refund you for the time you were receiving it before you told us you’d changed your mind.</li>
            <li>We refund you as soon as possible and within 14 days of you telling us you've changed your mind. We refund you by the method you used for payment. We don't charge a fee for the refund.</li>
            <li>For subscriptions purchased through the Apple App Store or any other app store, you will also need to access your account with that store and follow instructions to change or cancel your subscription. You may also contact <a href="mailto:support@hart.co">support@hart.co</a> for additional support.</li>
        </ol>
    </section>

    <section>
        <h2>User Content</h2>
        <ol>
            <li>Hart members can use Hart to store or share content such as text, files, documents, messages, articles, blogs, social media links, graphics, images, music, software, audio and video on Hart, including in posts or communications with others (“User Content”).</li>
            <li>Any User Content that you post or make available through Hart is referred to as “Your Content”. Your Content must comply with these Terms, including the Community Rules as set out below. You are solely responsible for all your User Content.</li>
            <li>We do not claim ownership of any User Content, and you grant to us a non-exclusive license to use, copy, modify, distribute, publicly display, and publicly perform Your Content on and in connection with Hart. This license will be free of charge, will last indefinitely, and we will have the right to grant these rights to third parties, like our service providers and other members.</li>
            <li>We may exercise all copyright and publicity rights in Your Content in all jurisdictions, to their full extent and for the full period for which any such rights exist in that material.</li>
            <li>You must have (and will have) all rights that are necessary to grant us the license rights in your User Content under these Terms.</li>
            <li>You agree that we are not responsible for, and do not endorse, any User Content and that we do not have any obligation to monitor, edit, or remove any User Content (see the Community Rules for more details of our moderation policy). The views expressed by other members do not represent our views or values.</li>
            <li>You can remove Your Content by specifically deleting it. You should know that in certain instances, such as complaints filed or deletion requests, some of Your Content may not be completely removed, and copies of Your Content may continue to exist on Hart even after you’ve deleted it.</li>
        </ol>
    </section>




    <footer>
        <p>For more information, contact us at <a href="mailto:support@hart.co">support@hart.co</a></p>
    </footer>

    <!-- Add your JavaScript scripts here if needed -->

</body>
</html>


                
                """,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
