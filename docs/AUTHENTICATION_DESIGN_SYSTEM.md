# Joojo Chat - Authentication Design System

## Design Identity

**Core Values**
- Premium & Luxury
- Modern & Elegant
- Dark Theme
- Purple + Gold Identity
- Material 3
- Arabic RTL Support
- Responsive
- Beautiful Animations
- Consistent Design System

---

## Color Palette

### Primary Colors
```
Primary Purple: #6366F1 (Indigo 500)
Primary Purple Dark: #4338CA (Indigo 700)
Primary Purple Light: #818CF8 (Indigo 400)
Primary Purple Container: #E0E7FF (Indigo 100)

Gold Accent: #D4AF37 (Metallic Gold)
Gold Light: #F4D03F
Gold Dark: #B8860B
Gold Container: #FEF9E7
```

### Background Colors
```
Background Primary: #0F0F1A (Deep Dark)
Background Secondary: #1A1A2E (Dark Blue)
Background Tertiary: #252542 (Lighter Dark)
Surface: #1E1E32
Surface Variant: #2A2A4A
```

### Text Colors
```
Text Primary: #FFFFFF
Text Secondary: #B8B8D0
Text Hint: #6B6B80
Text Disabled: #4A4A60
Text Error: #EF4444
Text Success: #10B981
```

### Gradient Colors
```
Primary Gradient: Linear Gradient (135deg)
  Start: #6366F1
  End: #8B5CF6

Gold Gradient: Linear Gradient (135deg)
  Start: #D4AF37
  End: #F4D03F

Dark Gradient: Linear Gradient (180deg)
  Start: #0F0F1A
  End: #1A1A2E

Button Gradient: Linear Gradient (135deg)
  Start: #6366F1
  End: #7C3AED
```

---

## Typography

### Font Family
```
Primary: Cairo (Google Fonts)
  - Arabic: Cairo
  - English: Cairo
```

### Font Sizes
```
Display Large: 57sp / Bold
Display Medium: 45sp / Bold
Display Small: 36sp / Bold

Headline Large: 32sp / SemiBold
Headline Medium: 28sp / SemiBold
Headline Small: 24sp / SemiBold

Title Large: 22sp / Medium
Title Medium: 16sp / Medium
Title Small: 14sp / Medium

Body Large: 16sp / Regular
Body Medium: 14sp / Regular
Body Small: 12sp / Regular

Label Large: 14sp / Medium
Label Medium: 12sp / Medium
Label Small: 11sp / Medium
```

### Line Heights
```
Tight: 1.0
Normal: 1.2
Relaxed: 1.5
Loose: 2.0
```

---

## Spacing System

### Scale
```
xxs: 4px
xs: 8px
sm: 12px
md: 16px
lg: 24px
xl: 32px
xxl: 48px
xxxl: 64px
```

### Usage
```
Page Padding: 24px (lg)
Section Spacing: 32px (xl)
Card Padding: 20px
Input Padding: 16px vertical, 16px horizontal
Button Padding: 16px vertical, 32px horizontal
Icon Button: 48px
List Item: 16px vertical
```

---

## Border Radius

### Scale
```
xs: 4px
sm: 8px
md: 12px
lg: 16px
xl: 24px
xxl: 32px
pill: 9999px
```

### Usage
```
Buttons: 12px (md)
Cards: 16px (lg)
Inputs: 12px (md)
Chips: 16px (lg)
Dialogs: 24px (xl)
Bottom Sheets: 24px top, 0 bottom
```

---

## Shadows

### Elevation Scale
```
xs: 0 1px 2px rgba(0,0,0,0.1)
sm: 0 2px 4px rgba(0,0,0,0.15)
md: 0 4px 8px rgba(0,0,0,0.2)
lg: 0 8px 16px rgba(0,0,0,0.25)
xl: 0 16px 32px rgba(0,0,0,0.3)
xxl: 0 24px 48px rgba(0,0,0,0.35)
```

### Colored Shadows
```
Primary Glow: 0 0 20px rgba(99, 102, 241, 0.3)
Gold Glow: 0 0 20px rgba(212, 175, 55, 0.3)
Error Glow: 0 0 20px rgba(239, 68, 68, 0.3)
Success Glow: 0 0 20px rgba(16, 185, 129, 0.3)
```

---

## Buttons

### Primary Button
```
Background: Primary Gradient
Text: White
Height: 56px
Border Radius: 12px
Elevation: md
Shadow: Primary Glow
```

**States:**
- Normal: Full gradient, shadow
- Pressed: Scale 0.98, shadow reduced
- Disabled: Opacity 0.5, no shadow
- Loading: Show spinner, text hidden

### Secondary Button
```
Background: Transparent
Border: 2px Primary Purple
Text: Primary Purple
Height: 56px
Border Radius: 12px
```

**States:**
- Normal: Transparent with primary border
- Pressed: Background primary with 0.1 opacity
- Disabled: Opacity 0.5

### Tertiary Button
```
Background: Transparent
Text: Primary Purple
Height: 48px
```

**States:**
- Normal: Transparent
- Pressed: Background primary with 0.05 opacity

### Social Buttons
```
Background: Surface Variant
Border: 1px Border Color
Icon: White
Text: Text Secondary
Height: 56px
Border Radius: 12px
```

**Social Icons:**
- Google: White (#FFFFFF)
- Facebook: #1877F2
- Apple: #FFFFFF

### Text Button
```
Background: Transparent
Text: Primary Purple
Height: 48px
```

---

## Text Fields

### Standard Input
```
Background: Surface
Border: 1px Border Color
Border Radius: 12px
Height: 56px
Padding: 16px horizontal
Label: Text Hint (12px, above)
Hint: Text Hint (14px, inside)
Text: Text Primary (16px)
Icon: Text Secondary (24px)
```

**States:**
- Normal: Surface background, border color
- Focus: Border Primary Purple, Primary Glow
- Error: Border Error, Error Glow
- Disabled: Opacity 0.5
- Filled: Label moves up, hint hidden

### Password Input
```
Same as Standard Input
Additional: Toggle visibility icon
```

### Search Input
```
Background: Surface Variant
Border: None
Border Radius: 16px
Height: 48px
Search Icon: Text Secondary
```

---

## Cards

### Standard Card
```
Background: Surface
Border Radius: 16px
Elevation: sm
Padding: 20px
```

### Elevated Card
```
Background: Surface
Border Radius: 16px
Elevation: lg
Padding: 24px
Border: 1px Border Color
```

### Glass Card
```
Background: Surface with 0.8 opacity
Backdrop Filter: Blur 10px
Border: 1px Border Color with 0.2 opacity
Border Radius: 16px
```

---

## Icons

### Icon Sizes
```
xs: 16px
sm: 20px
md: 24px
lg: 32px
xl: 48px
xxl: 64px
```

### Icon Colors
```
Primary: Primary Purple
Secondary: Text Secondary
Hint: Text Hint
Disabled: Text Disabled
Error: Text Error
Success: Text Success
Gold: Gold Accent
```

---

## Motion & Animations

### Duration
```
Fast: 150ms
Normal: 300ms
Slow: 500ms
Slower: 700ms
```

### Curves
```
Ease In: Cubic(0.4, 0.0, 1.0, 1.0)
Ease Out: Cubic(0.0, 0.0, 0.2, 1.0)
Ease In Out: Cubic(0.4, 0.0, 0.2, 1.0)
Bounce: Cubic(0.68, -0.55, 0.265, 1.55)
```

### Animation Types
```
Fade: Opacity 0 → 1
Scale: Scale 0.8 → 1.0
Slide: Translate Y 20px → 0
Shimmer: Gradient sweep
Pulse: Scale 1.0 → 1.05 → 1.0
```

### Page Transitions
```
Push: Slide in from right, fade in
Pop: Slide out to right, fade out
Modal: Scale up from center, fade in
Bottom Sheet: Slide up from bottom
```

---

## Dialogs

### Standard Dialog
```
Background: Surface
Border Radius: 24px
Elevation: xl
Max Width: 400px
Padding: 24px
```

### Content Structure
```
- Title (Headline Medium)
- Description (Body Medium)
- Actions (2 buttons max)
```

---

## Bottom Sheets

### Standard Bottom Sheet
```
Background: Surface
Border Radius: 24px top
Elevation: xl
Padding: 24px
Drag Handle: 40px wide, 4px high
```

### Modal Bottom Sheet
```
Same as Standard
Dark overlay with 0.6 opacity
```

---

## Progress Indicators

### Circular Progress
```
Stroke Width: 4px
Size: 24px, 32px, 48px
Color: Primary Purple
Track Color: Surface Variant
```

### Linear Progress
```
Height: 4px
Color: Primary Gradient
Track Color: Surface Variant
Border Radius: 2px
```

---

## Chips

### Standard Chip
```
Background: Surface Variant
Border Radius: 16px
Padding: 8px 16px
Text: Label Medium
```

### Filter Chip
```
Background: Transparent
Border: 1px Border Color
Selected: Primary Purple background, White text
```

---

## Badges

### Notification Badge
```
Background: Error
Text: White
Size: 16px
Border Radius: 8px
```

---

## Divider
```
Height: 1px
Color: Border Color
Opacity: 0.1
```

---

## RTL Support

### Text Direction
```
All text: RTL for Arabic, LTR for English
Icons: Mirrored for RTL
Layout: Flipped for RTL
```

---

## Responsive Breakpoints
```
Mobile: < 600px
Tablet: 600px - 900px
Desktop: > 900px
```

---

## Accessibility

### Contrast Ratios
```
Normal Text: 4.5:1
Large Text: 3:1
UI Components: 3:1
```

### Touch Targets
```
Minimum: 44px x 44px
Recommended: 48px x 48px
```

---

## Design Tokens Summary

### Colors
- Primary: #6366F1
- Gold: #D4AF37
- Background: #0F0F1A
- Surface: #1E1E32

### Typography
- Font: Cairo
- Headline: 32sp SemiBold
- Body: 16sp Regular

### Spacing
- Base: 8px
- Page: 24px
- Section: 32px

### Radius
- Buttons: 12px
- Cards: 16px
- Inputs: 12px

### Shadows
- Elevation: 0 4px 8px
- Glow: 0 0 20px

### Animation
- Duration: 300ms
- Curve: Ease Out
