# Joojo Chat - Authentication Screens Design Specifications

---

## 1. Login Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Back Icon]  Welcome Back          │
│                                     │
│  [Logo]                             │
│  Joojo Chat                         │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Email / Phone Number       │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Password              [Eye]  │   │
│  └─────────────────────────────┘   │
│                                     │
│  Forgot Password?                  │
│                                     │
│  [     Login Button     ]           │
│                                     │
│  ─────── or ───────                │
│                                     │
│  [Google]  [Facebook]  [Apple]     │
│                                     │
│  Don't have an account? Sign Up     │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Back Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: arrow_back_ios
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Welcome Text**:
  - Text: "Welcome Back" (Arabic: "مرحباً بعودتك")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Logo Section
- **Logo**:
  - Icon: chat_bubble_rounded
  - Size: 80px
  - Color: Primary Gradient
  - Glow: Primary Glow
  - Animation: Pulse (2s duration)

- **App Name**:
  - Text: "Joojo Chat"
  - Style: Title Large (22sp, Medium)
  - Color: Text Primary
  - Letter Spacing: 2px
  - Margin: 16px top

#### Input Fields

##### Email/Phone Input
- **Label**: "Email or Phone Number" (Arabic: "البريد الإلكتروني أو رقم الهاتف")
- **Placeholder**: "Enter your email or phone" (Arabic: "أدخل بريدك الإلكتروني أو رقم هاتفك")
- **Icon**: person_outline (24px, Text Secondary)
- **Toggle Icon**: phone/email toggle
- **Height**: 56px
- **Border Radius**: 12px
- **Background**: Surface
- **Border**: 1px Border Color
- **Padding**: 16px horizontal, 16px vertical
- **Spacing**: 24px bottom

##### Password Input
- **Label**: "Password" (Arabic: "كلمة المرور")
- **Placeholder**: "Enter your password" (Arabic: "أدخل كلمة المرور")
- **Icon**: lock_outline (24px, Text Secondary)
- **Toggle Icon**: visibility/visibility_off
- **Height**: 56px
- **Border Radius**: 12px
- **Background**: Surface
- **Border**: 1px Border Color
- **Padding**: 16px horizontal, 16px vertical
- **Spacing**: 16px bottom

#### Forgot Password
- **Text**: "Forgot Password?" (Arabic: "نسيت كلمة المرور؟")
- **Style**: Label Medium (12px, Medium)
- **Color**: Primary Purple
- **Alignment**: Right (RTL: Left)
- **Margin**: 8px bottom

#### Login Button
- **Text**: "Login" (Arabic: "تسجيل الدخول")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Elevation**: md
- **Margin**: 24px top, 32px bottom
- **Animation**: Scale on press (0.98)

#### Divider
- **Text**: "or" (Arabic: "أو")
- **Style**: Label Medium (12px, Medium)
- **Color**: Text Hint
- **Lines**: 1px Border Color, 20% opacity
- **Margin**: 24px top, 24px bottom

#### Social Login Buttons
- **Layout**: Horizontal row, 3 buttons
- **Button Size**: 56px x 56px (square)
- **Border Radius**: 12px
- **Background**: Surface Variant
- **Border**: 1px Border Color
- **Spacing**: 16px between buttons
- **Icons**:
  - Google: 32px, White
  - Facebook: 32px, #1877F2
  - Apple: 32px, White

#### Sign Up Link
- **Text**: "Don't have an account? " + "Sign Up" (Arabic: "ليس لديك حساب؟ " + "سجل الآن")
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary + Primary Purple (link)
- **Alignment**: Center
- **Margin**: 32px top

### UI States

#### Normal State
- All inputs: Surface background, Border Color
- Login button: Full gradient, shadow
- Social buttons: Surface Variant background

#### Focus State (Email Input)
- Border: Primary Purple (2px)
- Glow: Primary Glow
- Label: Moves up, Primary Purple color
- Background: Surface

#### Focus State (Password Input)
- Border: Primary Purple (2px)
- Glow: Primary Glow
- Label: Moves up, Primary Purple color
- Background: Surface

#### Error State (Email)
- Border: Error (2px)
- Glow: Error Glow
- Error Message: "Invalid email or phone number"
- Color: Text Error
- Position: Below input

#### Error State (Password)
- Border: Error (2px)
- Glow: Error Glow
- Error Message: "Password is required"
- Color: Text Error
- Position: Below input

#### Loading State
- Login button: 
  - Text hidden
  - Circular progress indicator (24px, White)
  - Opacity: 0.8
  - Disabled: true

#### Disabled State
- Login button:
  - Opacity: 0.5
  - Shadow: none
  - Disabled: true

### Animations

#### Entry Animation
- Duration: 600ms
- Sequence:
  1. Logo fades in (0-200ms)
  2. App name slides up (200-400ms)
  3. Inputs fade in one by one (400-600ms)
  4. Button fades in (600-800ms)
  5. Social buttons fade in (800-1000ms)

#### Input Focus Animation
- Duration: 200ms
- Border color transition: Ease Out
- Glow animation: Pulse (1s)

#### Button Press Animation
- Duration: 100ms
- Scale: 1.0 → 0.98 → 1.0
- Curve: Ease In Out

### Responsive Design

#### Mobile (< 600px)
- Padding: 24px
- Input height: 56px
- Button height: 56px
- Social buttons: 56px x 56px

#### Tablet (600px - 900px)
- Max width: 500px
- Centered horizontally
- Padding: 32px
- Input height: 56px
- Button height: 56px

#### Desktop (> 900px)
- Max width: 450px
- Centered horizontally
- Padding: 40px
- Card background with shadow
- Border radius: 24px

### Accessibility

#### Focus Indicators
- Input focus: 2px Primary Purple border
- Button focus: 2px Primary Purple outline
- Focus ring: 4px offset

#### Touch Targets
- Minimum: 48px x 48px
- Social buttons: 56px x 56px
- Login button: 56px height

#### Screen Reader
- Labels: All inputs have semantic labels
- Hints: Placeholder text as hint
- Error messages: Announced when shown

---

## 2. Register Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Back Icon]  Create Account        │
│                                     │
│  [Logo]                             │
│  Join Joojo Chat                    │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Username                    │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Full Name                   │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Email                       │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Phone Number                │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Password              [Eye]  │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Confirm Password      [Eye]  │   │
│  └─────────────────────────────┘   │
│                                     │
│  [☐] I agree to Terms & Privacy    │
│                                     │
│  [   Create Account Button   ]      │
│                                     │
│  Already have an account? Login    │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Back Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: arrow_back_ios
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Create Account Text**:
  - Text: "Create Account" (Arabic: "إنشاء حساب")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Logo Section
- **Logo**:
  - Icon: person_add_rounded
  - Size: 80px
  - Color: Primary Gradient
  - Glow: Primary Glow

- **Subtitle**:
  - Text: "Join Joojo Chat" (Arabic: "انضم إلى جوجو شات")
  - Style: Title Medium (16px, Medium)
  - Color: Text Secondary
  - Margin: 16px top

#### Input Fields

##### Username Input
- **Label**: "Username" (Arabic: "اسم المستخدم")
- **Placeholder**: "Choose a username" (Arabic: "اختر اسم المستخدم")
- **Icon**: person_outline (24px, Text Secondary)
- **Validation**: 3-20 characters, alphanumeric
- **Height**: 56px
- **Spacing**: 16px bottom

##### Full Name Input
- **Label**: "Full Name" (Arabic: "الاسم الكامل")
- **Placeholder**: "Enter your full name" (Arabic: "أدخل اسمك الكامل")
- **Icon**: badge_outline (24px, Text Secondary)
- **Height**: 56px
- **Spacing**: 16px bottom

##### Email Input
- **Label**: "Email" (Arabic: "البريد الإلكتروني")
- **Placeholder**: "Enter your email" (Arabic: "أدخل بريدك الإلكتروني")
- **Icon**: email_outline (24px, Text Secondary)
- **Validation**: Email format
- **Height**: 56px
- **Spacing**: 16px bottom

##### Phone Number Input
- **Label**: "Phone Number" (Arabic: "رقم الهاتف")
- **Placeholder**: "Enter your phone number" (Arabic: "أدخل رقم هاتفك")
- **Icon**: phone_outline (24px, Text Secondary)
- **Country Code**: Dropdown (+966, +971, etc.)
- **Validation**: 10-15 digits
- **Height**: 56px
- **Spacing**: 16px bottom

##### Password Input
- **Label**: "Password" (Arabic: "كلمة المرور")
- **Placeholder**: "Create a password" (Arabic: "أنشئ كلمة مرور")
- **Icon**: lock_outline (24px, Text Secondary)
- **Toggle**: visibility/visibility_off
- **Strength Indicator**: Weak/Medium/Strong
- **Height**: 56px
- **Spacing**: 16px bottom

##### Confirm Password Input
- **Label**: "Confirm Password" (Arabic: "تأكيد كلمة المرور")
- **Placeholder**: "Confirm your password" (Arabic: "أكد كلمة المرور")
- **Icon**: lock_outline (24px, Text Secondary)
- **Toggle**: visibility/visibility_off
- **Height**: 56px
- **Spacing**: 24px bottom

#### Terms & Privacy Checkbox
- **Checkbox**: Custom styled
  - Unchecked: Border Color border, 20px x 20px
  - Checked: Primary Purple background, check icon
  - Border Radius: 4px
- **Text**: "I agree to " + "Terms" + " and " + "Privacy Policy"
- **Style**: Label Small (11px, Medium)
- **Color**: Text Secondary + Primary Purple (links)
- **Spacing**: 16px bottom

#### Create Account Button
- **Text**: "Create Account" (Arabic: "إنشاء حساب")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Margin**: 24px top, 32px bottom

#### Login Link
- **Text**: "Already have an account? " + "Login" (Arabic: "لديك حساب بالفعل؟ " + "سجل الدخول")
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary + Primary Purple (link)
- **Alignment**: Center
- **Margin**: 32px top

### Password Strength Indicator

#### Weak
- **Color**: Error (#EF4444)
- **Text**: "Weak"
- **Progress**: 1/3 bars filled

#### Medium
- **Color**: Gold (#D4AF37)
- **Text**: "Medium"
- **Progress**: 2/3 bars filled

#### Strong
- **Color**: Success (#10B981)
- **Text**: "Strong"
- **Progress**: 3/3 bars filled

### UI States

#### Validation States
- **Username Valid**: Green check icon
- **Username Invalid**: Error message below
- **Email Valid**: Green check icon
- **Email Invalid**: Error message below
- **Password Mismatch**: Error message below confirm password

#### Loading State
- Button: Circular progress, text hidden
- All inputs: Disabled

#### Success State
- Button: Success color, check icon
- Navigate to OTP verification

### Animations

#### Entry Animation
- Duration: 800ms
- Staggered fade-in for each input
- Logo animation: Scale up + rotate

#### Password Strength Animation
- Duration: 300ms
- Color transition: Ease Out
- Progress bar: Fill animation

### Responsive Design

#### Mobile (< 600px)
- Scrollable content
- Padding: 24px
- Input height: 56px

#### Tablet (600px - 900px)
- Max width: 500px
- Centered
- Padding: 32px

#### Desktop (> 900px)
- Max width: 450px
- Centered card
- Padding: 40px

---

## 3. Email Verification (OTP) Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Back Icon]  Verify Email          │
│                                     │
│  [Email Icon]                       │
│  Enter the code sent to             │
│  user@example.com                   │
│                                     │
│  ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐    │
│  │  │ │  │ │  │ │  │ │  │ │  │    │
│  └──┘ └──┘ └──┘ └──┘ └──┘ └──┘    │
│                                     │
│  Resend code in 02:59               │
│                                     │
│  [   Verify Button     ]            │
│                                     │
│  Didn't receive code? Resend        │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Back Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: arrow_back_ios
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Verify Email Text**:
  - Text: "Verify Email" (Arabic: "تأكيد البريد الإلكتروني")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Icon Section
- **Email Icon**:
  - Icon: mark_email_read_rounded
  - Size: 80px
  - Color: Primary Gradient
  - Glow: Primary Glow
  - Animation: Pulse (2s)

#### Description Text
- **Line 1**: "Enter the code sent to" (Arabic: "أدخل الكود المرسل إلى")
- **Line 2**: "user@example.com"
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary + Text Primary
- **Alignment**: Center
- **Margin**: 24px top

#### OTP Input Fields
- **Layout**: 6 boxes, horizontal row
- **Box Size**: 48px x 56px
- **Border Radius**: 12px
- **Background**: Surface
- **Border**: 2px Border Color
- **Text**: Title Large (22sp, SemiBold)
- **Color**: Text Primary
- **Alignment**: Center
- **Spacing**: 8px between boxes
- **Max Length**: 1 digit per box

#### OTP Input States

##### Normal State
- Background: Surface
- Border: Border Color
- Text: Empty

#### Focused State
- Background: Surface
- Border: Primary Purple (2px)
- Glow: Primary Glow
- Cursor: Blinking

#### Filled State
- Background: Primary Container (10% opacity)
- Border: Primary Purple
- Text: Entered digit
- Animation: Scale (1.1 → 1.0)

#### Error State
- Background: Error Container (10% opacity)
- Border: Error
- Text: Error color
- Glow: Error Glow
- Shake animation

#### Success State
- Background: Success Container (10% opacity)
- Border: Success
- Text: Success color
- Glow: Success Glow

#### Countdown Timer
- **Text**: "Resend code in 02:59" (Arabic: "إعادة إرسال الكود خلال 02:59")
- **Style**: Label Medium (12px, Medium)
- **Color**: Text Hint
- **Alignment**: Center
- **Margin**: 32px top
- **Animation**: Update every second

#### Resend Link
- **State**: Disabled during countdown
- **Enabled after**: 60 seconds
- **Text**: "Resend code" (Arabic: "إعادة إرسال الكود")
- **Style**: Label Medium (12px, Medium)
- **Color**: Primary Purple
- **Underline**: Yes
- **Alignment**: Center
- **Margin**: 8px top

#### Verify Button
- **Text**: "Verify" (Arabic: "تأكيد")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Margin**: 32px top, 24px bottom
- **Disabled**: Until 6 digits entered

### UI States

#### Loading State
- Button: Circular progress, text hidden
- All OTP boxes: Disabled

#### Success State
- All boxes: Success color
- Button: Success color, check icon
- Success animation: Confetti or check mark
- Auto-navigate after 2 seconds

#### Error State
- All boxes: Error color
- Error message: "Invalid code"
- Shake animation on boxes
- Button: Enabled for retry

### Animations

#### Entry Animation
- Duration: 600ms
- Icon: Scale up + fade
- Text: Slide up + fade
- OTP boxes: Staggered fade-in

#### OTP Input Animation
- Focus: Border color transition (200ms)
- Fill: Scale bounce (300ms)
- Error: Shake (400ms)
- Success: Green glow pulse (500ms)

#### Countdown Animation
- Pulse on last 10 seconds
- Color change to Primary Purple when enabled

### Auto-Fill Behavior
- Auto-focus first box on load
- Auto-advance to next box on digit entry
- Auto-focus previous box on backspace
- Auto-submit when all 6 digits entered

### Responsive Design

#### Mobile (< 600px)
- Box size: 48px x 56px
- Spacing: 8px
- Padding: 24px

#### Tablet (600px - 900px)
- Box size: 56px x 64px
- Spacing: 12px
- Max width: 500px

#### Desktop (> 900px)
- Box size: 64px x 72px
- Spacing: 16px
- Max width: 450px

---

## 4. Forgot Password Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Back Icon]  Forgot Password      │
│                                     │
│  [Lock Icon]                       │
│  Don't worry, we'll help you       │
│  reset your password               │
│                                     │
│  [Email] [Phone] - Toggle          │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Email / Phone Number       │   │
│  └─────────────────────────────┘   │
│                                     │
│  [   Send Reset Link    ]           │
│                                     │
│  Remember password? Login          │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Back Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: arrow_back_ios
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Forgot Password Text**:
  - Text: "Forgot Password" (Arabic: "نسيت كلمة المرور")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Icon Section
- **Lock Icon**:
  - Icon: lock_reset_rounded
  - Size: 80px
  - Color: Gold Gradient
  - Glow: Gold Glow
  - Animation: Pulse (2s)

#### Description Text
- **Text**: "Don't worry, we'll help you reset your password"
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary
- **Alignment**: Center
- **Margin**: 24px top

#### Method Toggle
- **Type**: Segmented control
- **Options**: Email / Phone
- **Selected**: Primary Purple background, White text
- **Unselected**: Surface background, Text Secondary text
- **Border Radius**: 12px
- **Height**: 48px
- **Margin**: 32px top, 24px bottom

#### Input Field

##### Email Mode
- **Label**: "Email" (Arabic: "البريد الإلكتروني")
- **Placeholder**: "Enter your email" (Arabic: "أدخل بريدك الإلكتروني")
- **Icon**: email_outline (24px, Text Secondary)
- **Height**: 56px

##### Phone Mode
- **Label**: "Phone Number" (Arabic: "رقم الهاتف")
- **Placeholder**: "Enter your phone number" (Arabic: "أدخل رقم هاتفك")
- **Icon**: phone_outline (24px, Text Secondary)
- **Country Code**: Dropdown
- **Height**: 56px

#### Send Reset Link Button
- **Text**: "Send Reset Link" (Arabic: "إرسال رابط إعادة التعيين")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Margin**: 32px top, 24px bottom

#### Login Link
- **Text**: "Remember password? " + "Login" (Arabic: "تتذكر كلمة المرور؟ " + "سجل الدخول")
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary + Primary Purple (link)
- **Alignment**: Center
- **Margin**: 32px top

### UI States

#### Loading State
- Button: Circular progress, text hidden
- Input: Disabled
- Toggle: Disabled

#### Success State
- Button: Success color, check icon
- Success message: "Reset link sent"
- Auto-navigate after 3 seconds

#### Error State
- Input: Error border, error message
- Button: Enabled for retry

### Animations

#### Entry Animation
- Duration: 600ms
- Icon: Scale up
- Text: Slide up
- Input: Fade in

#### Toggle Animation
- Duration: 300ms
- Slide animation between options
- Background color transition

#### Success Animation
- Check mark animation
- Confetti effect

### Responsive Design

#### Mobile (< 600px)
- Padding: 24px
- Input height: 56px

#### Tablet (600px - 900px)
- Max width: 500px
- Centered
- Padding: 32px

#### Desktop (> 900px)
- Max width: 450px
- Centered card
- Padding: 40px

---

## 5. Reset Password Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Back Icon]  Reset Password        │
│                                     │
│  [Lock Icon]                       │
│  Create your new password           │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ New Password          [Eye]  │   │
│  └─────────────────────────────┘   │
│                                     │
│  Password Strength: [|||||] Strong │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Confirm Password      [Eye]  │   │
│  └─────────────────────────────┘   │
│                                     │
│  [   Reset Password Button  ]       │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Back Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: arrow_back_ios
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Reset Password Text**:
  - Text: "Reset Password" (Arabic: "إعادة تعيين كلمة المرور")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Icon Section
- **Lock Icon**:
  - Icon: vpn_key_rounded
  - Size: 80px
  - Color: Primary Gradient
  - Glow: Primary Glow
  - Animation: Rotate (360°, 2s)

#### Description Text
- **Text**: "Create your new password" (Arabic: "أنشئ كلمة المرور الجديدة")
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary
- **Alignment**: Center
- **Margin**: 24px top

#### Input Fields

##### New Password Input
- **Label**: "New Password" (Arabic: "كلمة المرور الجديدة")
- **Placeholder**: "Enter new password" (Arabic: "أدخل كلمة المرور الجديدة")
- **Icon**: lock_outline (24px, Text Secondary)
- **Toggle**: visibility/visibility_off
- **Height**: 56px
- **Spacing**: 8px bottom

##### Password Strength Indicator
- **Layout**: 5 bars + text label
- **Bars**: 8px height, 24px width each
- **Spacing**: 4px between bars
- **Colors**: Error → Gold → Success
- **Text**: "Weak" / "Medium" / "Strong"
- **Style**: Label Small (11px, Medium)
- **Spacing**: 16px bottom

##### Confirm Password Input
- **Label**: "Confirm Password" (Arabic: "تأكيد كلمة المرور")
- **Placeholder**: "Confirm new password" (Arabic: "أكد كلمة المرور الجديدة")
- **Icon**: lock_outline (24px, Text Secondary)
- **Toggle**: visibility/visibility_off
- **Height**: 56px
- **Spacing**: 24px bottom

#### Reset Password Button
- **Text**: "Reset Password" (Arabic: "إعادة تعيين كلمة المرور")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Margin**: 32px top

### Password Strength Requirements

#### Indicators
- **Length**: 8+ characters
- **Uppercase**: At least 1 uppercase letter
- **Lowercase**: At least 1 lowercase letter
- **Number**: At least 1 number
- **Special**: At least 1 special character

#### Visual Feedback
- **Met**: Green check icon
- **Not Met**: Gray circle
- **Position**: Below password field

### UI States

#### Loading State
- Button: Circular progress, text hidden
- All inputs: Disabled

#### Success State
- Button: Success color, check icon
- Success animation
- Auto-navigate to login after 2 seconds

#### Error States
- **Password Mismatch**: Error message below confirm password
- **Password Too Weak**: Error message, strength indicator red
- **Network Error**: Error snackbar

### Animations

#### Entry Animation
- Duration: 600ms
- Icon: Rotate + fade
- Text: Slide up
- Inputs: Staggered fade-in

#### Strength Animation
- Duration: 300ms
- Bars fill sequentially
- Color transitions

#### Success Animation
- Check mark animation
- Button color transition

### Responsive Design

#### Mobile (< 600px)
- Padding: 24px
- Input height: 56px

#### Tablet (600px - 900px)
- Max width: 500px
- Centered
- Padding: 32px

#### Desktop (> 900px)
- Max width: 450px
- Centered card
- Padding: 40px

---

## 6. Complete Profile Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Back Icon]  Complete Profile      │
│                                     │
│  [Avatar Upload]                    │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Username                    │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Full Name                   │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Country              [▼]     │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Date of Birth        [📅]    │   │
│  └─────────────────────────────┘   │
│                                     │
│  [Male] [Female] [Other]            │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Short Bio                   │   │
│  │                             │   │
│  │                             │   │
│  └─────────────────────────────┘   │
│                                     │
│  [   Continue Button     ]           │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Back Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: arrow_back_ios
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Complete Profile Text**:
  - Text: "Complete Profile" (Arabic: "إكمال الملف الشخصي")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Avatar Upload Section
- **Avatar Container**:
  - Size: 120px x 120px
  - Border Radius: 60px (circle)
  - Background: Surface Variant
  - Border: 2px dashed Border Color
  - Icon: camera_alt_rounded (32px, Text Hint)
  - Position: Center
  - Margin: 24px top

- **Avatar States**:
  - **Empty**: Camera icon, dashed border
  - **Loaded**: User image, solid border
  - **Hover**: Overlay with edit icon

- **Edit Button**:
  - Position: Bottom right of avatar
  - Size: 36px x 36px
  - Background: Primary Purple
  - Border Radius: 18px
  - Icon: edit (16px, White)
  - Border: 2px Background

#### Input Fields

##### Username Input
- **Label**: "Username" (Arabic: "اسم المستخدم")
- **Placeholder**: "Choose a username" (Arabic: "اختر اسم المستخدم")
- **Icon**: person_outline (24px, Text Secondary)
- **Validation**: 3-20 characters, alphanumeric
- **Height**: 56px
- **Spacing**: 16px bottom

##### Full Name Input
- **Label**: "Full Name" (Arabic: "الاسم الكامل")
- **Placeholder**: "Enter your full name" (Arabic: "أدخل اسمك الكامل")
- **Icon**: badge_outline (24px, Text Secondary)
- **Height**: 56px
- **Spacing**: 16px bottom

##### Country Selector
- **Label**: "Country" (Arabic: "البلد")
- **Placeholder**: "Select your country" (Arabic: "اختر بلدك")
- **Icon**: public_outline (24px, Text Secondary)
- **Dropdown Icon**: arrow_drop_down
- **Height**: 56px
- **Spacing**: 16px bottom

##### Date of Birth Input
- **Label**: "Date of Birth" (Arabic: "تاريخ الميلاد")
- **Placeholder**: "Select your date of birth" (Arabic: "اختر تاريخ ميلادك")
- **Icon**: calendar_today_outline (24px, Text Secondary)
- **Calendar Icon**: calendar_today
- **Height**: 56px
- **Spacing**: 16px bottom

#### Gender Selection
- **Layout**: Horizontal row, 3 options
- **Type**: Choice chips
- **Options**: Male / Female / Other
- **Unselected**: Surface background, Text Secondary
- **Selected**: Primary Purple background, White text
- **Border Radius**: 16px
- **Height**: 40px
- **Padding**: 12px 24px
- **Spacing**: 12px between options
- **Margin**: 16px bottom

#### Short Bio Input
- **Label**: "Short Bio" (Arabic: "نبذة مختصرة")
- **Placeholder**: "Tell us about yourself..." (Arabic: "أخبرنا عن نفسك...")
- **Type**: Multi-line text field
- **Max Lines**: 4
- **Min Lines**: 2
- **Character Count**: 0/160
- **Height**: 120px
- **Border Radius**: 12px
- **Spacing**: 24px bottom

#### Continue Button
- **Text**: "Continue" (Arabic: "متابعة")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Margin**: 32px top

### UI States

#### Avatar States
- **Empty**: Camera icon, dashed border
- **Uploading**: Progress indicator
- **Loaded**: User image
- **Error**: Error icon, red border

#### Input Validation
- **Username**: Real-time validation, green check if valid
- **Full Name**: Required field
- **Country**: Required field
- **Date of Birth**: Required field, must be 18+
- **Gender**: Required field
- **Bio**: Optional, max 160 characters

#### Loading State
- Button: Circular progress, text hidden
- All inputs: Disabled

#### Success State
- Button: Success color, check icon
- Navigate to Creating Account screen

### Animations

#### Entry Animation
- Duration: 800ms
- Avatar: Scale up + fade
- Inputs: Staggered slide-up

#### Avatar Animation
- Upload: Progress circle
- Success: Scale bounce

#### Gender Selection Animation
- Selection: Scale (0.95 → 1.0)
- Color transition: 200ms

### Responsive Design

#### Mobile (< 600px)
- Padding: 24px
- Avatar: 100px x 100px
- Input height: 56px

#### Tablet (600px - 900px)
- Max width: 500px
- Centered
- Padding: 32px
- Avatar: 120px x 120px

#### Desktop (> 900px)
- Max width: 450px
- Centered card
- Padding: 40px
- Avatar: 120px x 120px

---

## 7. Avatar Upload Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│  [Close Icon]  Upload Avatar        │
│                                     │
│  [Avatar Preview - 200px]           │
│                                     │
│  ┌─────────────────────────────┐   │
│  │      Camera                 │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │      Gallery                │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │      Remove Photo           │   │
│  └─────────────────────────────┘   │
│                                     │
│  [   Save Button     ]               │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Header Section
- **Close Icon**: 
  - Position: Top left (RTL: Top right)
  - Icon: close
  - Size: 24px
  - Color: Text Secondary
  - Padding: 16px

- **Upload Avatar Text**:
  - Text: "Upload Avatar" (Arabic: "رفع الصورة الرمزية")
  - Style: Headline Large (32sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Padding: 24px top

#### Avatar Preview
- **Size**: 200px x 200px
- **Border Radius**: 100px (circle)
- **Background**: Surface Variant
- **Border**: 3px Border Color
- **Default Icon**: person_rounded (80px, Text Hint)
- **Loaded Image**: Cover fit
- **Edit Overlay**: 
  - Background: Black with 0.5 opacity
  - Icon: edit (32px, White)
  - Visible on hover/press
- **Margin**: 32px top

#### Action Buttons

##### Camera Button
- **Icon**: camera_alt_rounded (32px, Gold)
- **Text**: "Camera" (Arabic: "الكاميرا")
- **Style**: Title Medium (16px, Medium)
- **Height**: 64px
- **Background**: Surface
- **Border**: 1px Border Color
- **Border Radius**: 16px
- **Layout**: Icon + Text (horizontal)
- **Spacing**: 16px between icon and text
- **Margin**: 16px bottom

##### Gallery Button
- **Icon**: photo_library_rounded (32px, Primary Purple)
- **Text**: "Gallery" (Arabic: "المعرض")
- **Style**: Title Medium (16px, Medium)
- **Height**: 64px
- **Background**: Surface
- **Border**: 1px Border Color
- **Border Radius**: 16px
- **Layout**: Icon + Text (horizontal)
- **Spacing**: 16px between icon and text
- **Margin**: 16px bottom

##### Remove Photo Button
- **Icon**: delete_rounded (32px, Error)
- **Text**: "Remove Photo" (Arabic: "إزالة الصورة")
- **Style**: Title Medium (16px, Medium)
- **Height**: 64px
- **Background**: Error Container (10% opacity)
- **Border**: 1px Error
- **Border Radius**: 16px
- **Layout**: Icon + Text (horizontal)
- **Spacing**: 16px between icon and text
- **Margin**: 16px bottom
- **Visible**: Only when photo is loaded

#### Save Button
- **Text**: "Save" (Arabic: "حفظ")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Margin**: 32px top
- **Disabled**: Until photo is selected

### UI States

#### Empty State
- Preview: Default icon
- Remove button: Hidden
- Save button: Disabled

#### Loaded State
- Preview: Selected image
- Remove button: Visible
- Save button: Enabled

#### Uploading State
- Preview: Progress indicator
- All buttons: Disabled

#### Success State
- Preview: Success check overlay
- Save button: Success color
- Auto-close after 1 second

#### Error State
- Preview: Error icon
- Error message: "Failed to upload image"
- Save button: Enabled for retry

### Image Picker Options

#### Camera
- Open device camera
- Capture photo
- Preview before confirm
- Crop option (square)

#### Gallery
- Open device gallery
- Select image
- Preview before confirm
- Crop option (square)
- Max file size: 5MB
- Supported formats: JPG, PNG

### Animations

#### Entry Animation
- Duration: 500ms
- Preview: Scale up
- Buttons: Staggered fade-in

#### Image Load Animation
- Duration: 300ms
- Fade in
- Scale (0.9 → 1.0)

#### Button Press Animation
- Duration: 100ms
- Scale (1.0 → 0.95 → 1.0)

#### Success Animation
- Check mark animation
- Pulse effect

### Responsive Design

#### Mobile (< 600px)
- Preview: 160px x 160px
- Button height: 56px
- Padding: 24px

#### Tablet (600px - 900px)
- Preview: 200px x 200px
- Button height: 64px
- Max width: 500px
- Padding: 32px

#### Desktop (> 900px)
- Preview: 200px x 200px
- Button height: 64px
- Max width: 450px
- Padding: 40px

---

## 8. Creating Account Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│                                     │
│         [Logo]                       │
│      Creating Account...            │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ✓ Account Creation          │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ✓ Profile Setup             │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ⏳ Wallet Initialization    │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ⏸ User Preferences          │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ⏸ Final Preparation         │   │
│  └─────────────────────────────┘   │
│                                     │
│      [Circular Progress]            │
│                                     │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Logo Section
- **Logo**:
  - Icon: chat_bubble_rounded
  - Size: 80px
  - Color: Primary Gradient
  - Glow: Primary Glow
  - Animation: Rotate (360°, 3s, infinite)

- **Title**:
  - Text: "Creating Account..." (Arabic: "جاري إنشاء الحساب...")
  - Style: Headline Medium (28sp, SemiBold)
  - Color: Text Primary
  - Alignment: Center
  - Margin: 24px top

#### Progress Steps

##### Step Item
- **Layout**: Horizontal row
- **Icon Size**: 24px
- **Text**: Title Medium (16px, Medium)
- **Height**: 56px
- **Padding**: 16px horizontal
- **Border Radius**: 12px
- **Spacing**: 16px between icon and text
- **Margin**: 8px bottom

##### Step States

###### Completed (✓)
- **Background**: Success Container (10% opacity)
- **Icon**: check_circle (Success color)
- **Text**: Text Primary
- **Animation**: Fade in + slide

###### In Progress (⏳)
- **Background**: Primary Container (10% opacity)
- **Icon**: hourglass_empty (Primary Purple)
- **Text**: Text Primary
- **Animation**: Pulse

###### Pending (⏸)
- **Background**: Surface
- **Icon**: radio_button_unchecked (Text Hint)
- **Text**: Text Hint
- **Animation**: None

#### Steps Order
1. **Account Creation** - Creating user record
2. **Profile Setup** - Saving profile data
3. **Wallet Initialization** - Creating wallet
4. **User Preferences** - Setting defaults
5. **Final Preparation** - Final setup

#### Circular Progress
- **Size**: 64px
- **Stroke Width**: 6px
- **Color**: Primary Gradient
- **Track Color**: Surface Variant
- **Position**: Center
- **Margin**: 48px top
- **Animation**: Rotate (360°, 1s, infinite)

### UI States

#### Normal State
- Steps animate sequentially
- Progress indicator updates
- Each step: 1-2 seconds

#### Success State
- All steps: Completed
- Progress indicator: 100%
- Auto-navigate to Success screen after 1 second

#### Error State
- Failed step: Error icon, error color
- Error message: "Failed to create account"
- Retry button appears
- Progress indicator: Pauses

### Animations

#### Entry Animation
- Duration: 500ms
- Logo: Scale up + rotate
- Title: Fade in
- Steps: Staggered fade-in

#### Step Progress Animation
- Duration: 300ms per step
- Icon transition: Radio → Hourglass → Check
- Background color transition
- Text color transition

#### Progress Animation
- Duration: 1s per rotation
- Continuous rotation
- Smooth easing

#### Success Animation
- All steps: Success color
- Confetti effect
- Scale bounce

### Timing

#### Step Durations
- Account Creation: 1500ms
- Profile Setup: 1500ms
- Wallet Initialization: 2000ms
- User Preferences: 1000ms
- Final Preparation: 1000ms
- **Total**: ~7 seconds

### Responsive Design

#### Mobile (< 600px)
- Padding: 24px
- Step height: 56px
- Progress: 56px

#### Tablet (600px - 900px)
- Max width: 500px
- Centered
- Padding: 32px
- Step height: 64px

#### Desktop (> 900px)
- Max width: 450px
- Centered card
- Padding: 40px
- Step height: 64px

---

## 9. Success Screen

### Layout Structure
```
┌─────────────────────────────────────┐
│                                     │
│         [Success Icon]              │
│                                     │
│      Account Created!              │
│                                     │
│  Welcome to Joojo Chat             │
│  Your account is ready to use      │
│                                     │
│                                     │
│  [   Start Now Button     ]          │
│                                     │
└─────────────────────────────────────┘
```

### Visual Specifications

#### Success Icon Section
- **Icon**:
  - Icon: check_circle_rounded
  - Size: 120px
  - Color: Success (#10B981)
  - Glow: Success Glow
  - Animation: 
    - Scale up (0 → 1.2 → 1.0)
    - Duration: 600ms
    - Curve: Bounce

- **Confetti**:
  - Type: Particle explosion
  - Colors: Primary Purple, Gold, Success
  - Duration: 2000ms
  - Trigger: On screen load

#### Title Text
- **Text**: "Account Created!" (Arabic: "تم إنشاء الحساب!")
- **Style**: Headline Large (32sp, SemiBold)
- **Color**: Text Primary
- **Alignment**: Center
- **Margin**: 32px top
- **Animation**: Slide up + fade (400ms)

#### Description Text
- **Line 1**: "Welcome to Joojo Chat" (Arabic: "مرحباً بك في جوجو شات")
- **Line 2**: "Your account is ready to use" (Arabic: "حسابك جاهز للاستخدام")
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Secondary
- **Alignment**: Center
- **Line Height**: 1.5
- **Margin**: 16px top
- **Animation**: Slide up + fade (500ms)

#### Start Now Button
- **Text**: "Start Now" (Arabic: "ابدأ الآن")
- **Style**: Title Medium (16px, Medium)
- **Height**: 56px
- **Background**: Primary Gradient
- **Border Radius**: 12px
- **Shadow**: Primary Glow
- **Width**: Full width
- **Margin**: 48px top
- **Animation**: Scale up + fade (600ms)

### UI States

#### Normal State
- All animations play on load
- Button: Enabled

#### Pressed State
- Button: Scale 0.98
- Navigate to Home screen

### Animations

#### Entry Animation Sequence
1. **0ms**: Icon starts scale up
2. **200ms**: Confetti starts
3. **400ms**: Title slides up
4. **500ms**: Description slides up
5. **600ms**: Button fades in

#### Icon Animation
- Scale: 0 → 1.2 → 1.0
- Duration: 600ms
- Curve: Bounce
- Glow: Pulse (2s, infinite)

#### Confetti Animation
- Type: Particle system
- Count: 50 particles
- Colors: Primary Purple, Gold, Success
- Duration: 2000ms
- Direction: Radial explosion

#### Button Animation
- Fade in: 0 → 1
- Scale: 0.9 → 1.0
- Duration: 300ms
- Curve: Ease Out

### Responsive Design

#### Mobile (< 600px)
- Icon: 100px
- Padding: 24px
- Button height: 56px

#### Tablet (600px - 900px)
- Icon: 120px
- Max width: 500px
- Centered
- Padding: 32px

#### Desktop (> 900px)
- Icon: 120px
- Max width: 450px
- Centered card
- Padding: 40px

---

## 10. Authentication Dialogs & Bottom Sheets

### 10.1 Terms & Privacy Dialog

#### Layout
```
┌─────────────────────────────┐
│  Terms & Privacy           │
│                             │
│  [Scrollable Content]       │
│  - Terms of Service         │
│  - Privacy Policy           │
│                             │
│  [Decline]  [Accept]        │
└─────────────────────────────┘
```

### 10.2 Country Selector Bottom Sheet

#### Layout
```
┌─────────────────────────────┐
│  ═════════════              │
│  Select Country             │
│                             │
│  [🔍 Search countries...]  │
│                             │
│  🇸🇦 Saudi Arabia           │
│  🇦🇪 United Arab Emirates   │
│  🇪🇬 Egypt                 │
│  ...                        │
└─────────────────────────────┘
```

### 10.3 Date Picker Bottom Sheet

#### Layout
```
┌─────────────────────────────┐
│  ═════════════              │
│  Select Date of Birth       │
│                             │
│  [Calendar View]            │
│                             │
│  [Cancel]  [Confirm]       │
└─────────────────────────────┘
```

### 10.4 Logout Confirmation Dialog

#### Layout
```
┌─────────────────────────────┐
│  Logout                     │
│                             │
│  Are you sure you want      │
│  to logout?                 │
│                             │
│  [Cancel]  [Logout]         │
└─────────────────────────────┘
```

### 10.5 Error Dialog

#### Layout
```
┌─────────────────────────────┐
│  Error                      │
│                             │
│  [Error Icon]               │
│                             │
│  Something went wrong       │
│  Please try again later     │
│                             │
│  [OK]                       │
└─────────────────────────────┘
```

---

## 11. UI States Reference

### 11.1 Input Field States

#### Normal State
- Background: Surface
- Border: 1px Border Color
- Text: Text Primary
- Label: Text Hint
- Icon: Text Secondary

#### Focus State
- Background: Surface
- Border: 2px Primary Purple
- Text: Text Primary
- Label: Primary Purple (moved up)
- Icon: Primary Purple
- Glow: Primary Glow

#### Error State
- Background: Error Container (10% opacity)
- Border: 2px Error
- Text: Error
- Label: Error
- Icon: Error
- Glow: Error Glow
- Error Message: Below input

#### Success State
- Background: Success Container (10% opacity)
- Border: 2px Success
- Text: Text Primary
- Label: Success
- Icon: Success
- Glow: Success Glow
- Check Icon: Right side

#### Disabled State
- Background: Surface
- Border: 1px Border Color (50% opacity)
- Text: Text Disabled
- Label: Text Disabled
- Icon: Text Disabled
- Opacity: 0.5

#### Loading State
- Background: Surface
- Border: 1px Border Color
- Text: Hidden
- Icon: Hidden
- Progress: Circular indicator (20px)

### 11.2 Button States

#### Normal State
- Background: Primary Gradient
- Text: White
- Shadow: Primary Glow
- Elevation: md

#### Pressed State
- Background: Primary Gradient
- Text: White
- Shadow: None
- Scale: 0.98
- Elevation: none

#### Disabled State
- Background: Primary Gradient
- Text: White
- Shadow: None
- Opacity: 0.5
- Elevation: none

#### Loading State
- Background: Primary Gradient
- Text: Hidden
- Shadow: None
- Progress: Circular indicator (24px, White)
- Opacity: 0.8

#### Success State
- Background: Success
- Text: White
- Icon: check
- Shadow: Success Glow
- Animation: Pulse

#### Error State
- Background: Error
- Text: White
- Icon: error
- Shadow: Error Glow
- Animation: Shake

### 11.3 Card States

#### Normal State
- Background: Surface
- Border: 1px Border Color
- Elevation: sm

#### Hover State
- Background: Surface
- Border: 1px Primary Purple
- Elevation: md
- Shadow: Primary Glow

#### Pressed State
- Background: Surface
- Border: 1px Primary Purple
- Elevation: sm
- Scale: 0.98

#### Disabled State
- Background: Surface
- Border: 1px Border Color
- Elevation: none
- Opacity: 0.5

### 11.4 Empty State

#### Layout
```
┌─────────────────────────────┐
│                             │
│      [Empty Icon]           │
│                             │
│  No data available          │
│                             │
│  [Refresh Button]           │
└─────────────────────────────┘
```

#### Visual Specifications
- **Icon**: inbox_rounded (64px, Text Hint)
- **Title**: "No data available" (Arabic: "لا توجد بيانات")
- **Style**: Body Medium (14px, Regular)
- **Color**: Text Hint
- **Button**: "Refresh" (Arabic: "تحديث")
- **Style**: Secondary button

---

## 12. Authentication Flow Summary

### Complete Flow
```
Splash Screen
  ↓ (Check onboarding status)
Onboarding Screen
  ↓ (Complete onboarding)
Login Screen
  ↓ (Login with email/phone/social)
Register Screen
  ↓ (Submit registration)
Email Verification (OTP)
  ↓ (Verify OTP)
Complete Profile Screen
  ↓ (Submit profile)
Avatar Upload Screen (optional)
  ↓ (Save avatar)
Creating Account Screen
  ↓ (Complete setup)
Success Screen
  ↓ (Start Now)
Home Screen
```

### Alternative Flows

#### Forgot Password Flow
```
Login Screen
  ↓ (Forgot Password)
Forgot Password Screen
  ↓ (Send reset link)
Email Verification (OTP)
  ↓ (Verify OTP)
Reset Password Screen
  ↓ (Reset password)
Login Screen
```

---

## 13. Database Flow (Supabase)

### Initial Records Creation

After successful registration, create these records:

#### 1. auth.users
- Supabase Auth automatically creates this
- Email/Phone verified
- User metadata stored

#### 2. users
- id: UUID (from auth.users)
- username: String (unique)
- email: String
- phone: String (nullable)
- created_at: Timestamp
- updated_at: Timestamp

#### 3. profiles
- id: UUID (from users)
- user_id: UUID (foreign key to users)
- full_name: String
- avatar_url: String (nullable)
- country: String
- date_of_birth: Date
- gender: String
- bio: String (nullable)
- created_at: Timestamp
- updated_at: Timestamp

#### 4. wallet
- id: UUID
- user_id: UUID (foreign key to users)
- balance: Decimal (default: 0)
- currency: String (default: "SAR")
- created_at: Timestamp
- updated_at: Timestamp

#### 5. user_levels
- id: UUID
- user_id: UUID (foreign key to users)
- level: Integer (default: 1)
- xp: Integer (default: 0)
- created_at: Timestamp
- updated_at: Timestamp

#### 6. user_settings
- id: UUID
- user_id: UUID (foreign key to users)
- language: String (default: "ar")
- notifications_enabled: Boolean (default: true)
- sound_enabled: Boolean (default: true)
- privacy_mode: Boolean (default: false)
- created_at: Timestamp
- updated_at: Timestamp

#### 7. user_statistics
- id: UUID
- user_id: UUID (foreign key to users)
- total_rooms_joined: Integer (default: 0)
- total_time_spent: Integer (default: 0) // in minutes
- total_gifts_sent: Integer (default: 0)
- total_gifts_received: Integer (default: 0)
- created_at: Timestamp
- updated_at: Timestamp

### Records NOT Created Initially

These will be created on first use:
- families
- agencies
- vip_subscriptions
- gifts
- frames
- vehicles
- rooms
- rankings
- inventory

---

## 14. Design Specifications Summary

### Color Usage
- **Primary Actions**: Primary Gradient (#6366F1 → #8B5CF6)
- **Secondary Actions**: Gold (#D4AF37)
- **Success**: Success (#10B981)
- **Error**: Error (#EF4444)
- **Backgrounds**: Dark theme (#0F0F1A, #1E1E32)
- **Text**: White with varying opacity

### Typography Hierarchy
- **Headlines**: 32sp, SemiBold (Primary actions)
- **Titles**: 16-22sp, Medium (Secondary actions)
- **Body**: 14-16sp, Regular (Content)
- **Labels**: 11-14px, Medium (Form labels)

### Spacing System
- **Base unit**: 8px
- **Page padding**: 24px (mobile), 32px (tablet), 40px (desktop)
- **Section spacing**: 32px
- **Element spacing**: 16px
- **Tight spacing**: 8px

### Border Radius
- **Buttons**: 12px
- **Inputs**: 12px
- **Cards**: 16px
- **Chips**: 16px
- **Dialogs**: 24px
- **Avatars**: 50% (circle)

### Shadows & Glows
- **Elevation**: 0 4px 8px rgba(0,0,0,0.2)
- **Primary Glow**: 0 0 20px rgba(99, 102, 241, 0.3)
- **Gold Glow**: 0 0 20px rgba(212, 175, 55, 0.3)
- **Success Glow**: 0 0 20px rgba(16, 185, 129, 0.3)
- **Error Glow**: 0 0 20px rgba(239, 68, 68, 0.3)

### Animation Timing
- **Fast**: 150ms (micro-interactions)
- **Normal**: 300ms (standard transitions)
- **Slow**: 500ms (page transitions)
- **Slower**: 700ms (complex animations)

### Animation Curves
- **Ease In**: Cubic(0.4, 0.0, 1.0, 1.0)
- **Ease Out**: Cubic(0.0, 0.0, 0.2, 1.0)
- **Ease In Out**: Cubic(0.4, 0.0, 0.2, 1.0)
- **Bounce**: Cubic(0.68, -0.55, 0.265, 1.55)

---

## 15. Accessibility Guidelines

### Contrast Ratios
- **Normal text**: 4.5:1 minimum
- **Large text**: 3:1 minimum
- **UI components**: 3:1 minimum

### Touch Targets
- **Minimum**: 44px x 44px
- **Recommended**: 48px x 48px
- **Buttons**: 56px height

### Focus States
- **Inputs**: 2px Primary Purple border
- **Buttons**: 2px Primary Purple outline
- **Focus ring**: 4px offset

### Screen Reader Support
- **Semantic labels**: All interactive elements
- **Live regions**: Error messages, success messages
- **Hints**: Placeholder text as hints
- **Announcements**: State changes

---

## 16. RTL Support

### Text Direction
- **Arabic**: RTL
- **English**: LTR
- **Auto-detect**: Based on locale

### Layout Mirroring
- **Icons**: Mirrored for RTL (arrows, etc.)
- **Padding**: Swapped (left ↔ right)
- **Alignment**: Swapped (left ↔ right)

### Icon Mirroring
- **Mirrored**: arrow_back_ios, arrow_forward_ios, etc.
- **Not mirrored**: Icons without direction

---

## 17. Responsive Breakpoints

### Mobile
- **Width**: < 600px
- **Padding**: 24px
- **Input height**: 56px
- **Button height**: 56px

### Tablet
- **Width**: 600px - 900px
- **Max content width**: 500px
- **Padding**: 32px
- **Input height**: 56px
- **Button height**: 56px

### Desktop
- **Width**: > 900px
- **Max content width**: 450px
- **Padding**: 40px
- **Input height**: 56px
- **Button height**: 56px
- **Card layout**: Centered with shadow

---

## 18. Motion Design Principles

### Purposeful Animation
- **Guide attention**: Focus on important elements
- **Provide feedback**: Confirm user actions
- **Show relationships**: Connect related elements
- **Create delight**: Subtle, premium feel

### Performance
- **60 FPS**: Smooth animations
- **Hardware acceleration**: GPU-based where possible
- **Minimal repaints**: Optimize for performance

### Consistency
- **Standard durations**: 150ms, 300ms, 500ms
- **Standard curves**: Ease Out, Ease In Out
- **Standard easing**: Consistent across app

---

## 19. Premium Design Elements

### Gradients
- **Primary**: #6366F1 → #8B5CF6 (135deg)
- **Gold**: #D4AF37 → #F4D03F (135deg)
- **Dark**: #0F0F1A → #1A1A2E (180deg)

### Glass Effect
- **Background**: Surface with 0.8 opacity
- **Backdrop**: Blur 10px
- **Border**: 1px Border Color with 0.2 opacity

### Glow Effects
- **Primary**: 0 0 20px rgba(99, 102, 241, 0.3)
- **Gold**: 0 0 20px rgba(212, 175, 55, 0.3)
- **Success**: 0 0 20px rgba(16, 185, 129, 0.3)
- **Error**: 0 0 20px rgba(239, 68, 68, 0.3)

### Premium Touches
- **Subtle shadows**: Depth without harshness
- **Smooth transitions**: No jarring movements
- **Consistent spacing**: Harmonious layout
- **Thoughtful typography**: Clear hierarchy
- **Purposeful color**: Emotional connection

---

## 20. Production Readiness Checklist

### Visual Design
- ✅ All screens designed
- ✅ All states defined
- ✅ Responsive layouts
- ✅ RTL support
- ✅ Dark theme
- ✅ Premium feel

### Interaction Design
- ✅ Input validation
- ✅ Error handling
- ✅ Loading states
- ✅ Success feedback
- ✅ Smooth animations
- ✅ Touch targets

### Accessibility
- ✅ Contrast ratios
- ✅ Focus indicators
- ✅ Screen reader support
- ✅ Touch targets
- ✅ Semantic labels

### Performance
- ✅ Optimized animations
- ✅ Efficient rendering
- ✅ Smooth 60 FPS
- ✅ Minimal repaints

### Consistency
- ✅ Design system applied
- ✅ Spacing consistent
- ✅ Typography consistent
- ✅ Color usage consistent
- ✅ Component reuse

---

**Document Version**: 1.0
**Last Updated**: 2026-07-12
**Status**: Complete
