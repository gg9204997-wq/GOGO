# Joojo Chat Database Design

## Table of Contents

1. [Complete List of Tables](#complete-list-of-tables)
2. [Table Purposes](#table-purposes)
3. [Relationships](#relationships)
4. [Primary Keys](#primary-keys)
5. [Foreign Keys](#foreign-keys)
6. [One-to-One Relations](#one-to-one-relations)
7. [One-to-Many Relations](#one-to-many-relations)
8. [Many-to-Many Relations](#many-to-many-relations)
9. [Suggested Indexes](#suggested-indexes)
10. [Storage Buckets](#storage-buckets)
11. [Enums](#enums)
12. [Row Level Security Strategy](#row-level-security-strategy)
13. [Authentication Flow](#authentication-flow)
14. [Wallet System Flow](#wallet-system-flow)
15. [Room System Flow](#room-system-flow)
16. [Gift System Flow](#gift-system-flow)
17. [Family System Flow](#family-system-flow)
18. [Agency System Flow](#agency-system-flow)
19. [Recharge Agency System Flow](#recharge-agency-system-flow)
20. [VIP System Flow](#vip-system-flow)
21. [Ranking System Flow](#ranking-system-flow)
22. [Notification System Flow](#notification-system-flow)
23. [Messaging System Flow](#messaging-system-flow)
24. [Store System Flow](#store-system-flow)
25. [Future Scalability Considerations](#future-scalability-considerations)

---

## Complete List of Tables

### Core User Tables
1. `users` - User profiles and account information
2. `user_profiles` - Extended user profile data
3. `user_settings` - User application settings
4. `user_preferences` - User preferences and configurations
5. `user_sessions` - Active user sessions
6. `user_devices` - User device information
7. `user_verifications` - User verification records

### Authentication & Security
8. `auth_providers` - External authentication providers
9. `user_auth_providers` - User authentication provider links
10. `password_resets` - Password reset tokens
11. `two_factor_auth` - Two-factor authentication settings
12. `security_logs` - Security event logs
13. `blocked_users` - User blocking relationships

### Wallet & Financial
14. `wallets` - User wallet accounts
15. `wallet_transactions` - Transaction history
16. `wallet_transaction_types` - Transaction type definitions
17. `wallet_balance_snapshots` - Wallet balance history for audit
18. `transaction_reconciliations` - Transaction reconciliation records
19. `recharge_packages` - Available recharge packages
20. `user_recharges` - User recharge records
21. `withdrawal_requests` - Withdrawal requests
22. `withdrawal_methods` - Available withdrawal methods
23. `currency_exchange_rates` - Currency exchange rate history
24. `currency_conversions` - Currency conversion tracking

### Agency System
21. `agencies` - Agency information
22. `agency_members` - Agency membership
23. `agency_roles` - Agency role definitions
24. `agency_permissions` - Agency permissions
25. `agency_commissions` - Commission structures
26. `agency_statistics` - Agency performance statistics
27. `recharge_agencies` - Recharge agency information
28. `recharge_agency_rates` - Recharge agency rates
29. `recharge_agency_transactions` - Recharge agency transactions

### Room System
30. `rooms` - Chat room information
31. `room_types` - Room type definitions
32. `room_categories` - Room categories
33. `room_members` - Room membership
34. `room_roles` - Room role definitions
35. `room_settings` - Room-specific settings
36. `room_statistics` - Room statistics
37. `room_bans` - Room ban records
38. `room_mutes` - Room mute records

### Messaging System
39. `messages` - Message records
40. `message_types` - Message type definitions
41. `message_reactions` - Message reactions
42. `message_pins` - Pinned messages
43. `message_reads` - Message read receipts
44. `message_deletions` - Message deletion records
45. `conversations` - Conversation metadata
46. `conversation_participants` - Conversation participants

### Gift System
47. `gifts` - Gift definitions
48. `gift_categories` - Gift categories
49. `gift_tiers` - Gift tier definitions
50. `user_gifts` - User gift inventory
51. `gift_transactions` - Gift transaction records (consolidated)
52. `gift_statistics` - Gift statistics

### VIP System
54. `vip_tiers` - VIP tier definitions
55. `vip_benefits` - VIP tier benefits
56. `user_vip_subscriptions` - User VIP subscriptions
57. `vip_purchase_history` - VIP purchase history

### Ranking & Level System
58. `levels` - User level definitions
59. `level_rewards` - Level rewards
60. `user_levels` - User level progress
61. `rankings` - Ranking definitions
62. `ranking_categories` - Ranking categories
63. `user_rankings` - User ranking positions
64. `ranking_history` - Ranking history

### Family System
65. `families` - Family information
66. `family_members` - Family membership
67. `family_roles` - Family role definitions
68. `family_settings` - Family settings
69. `family_requests` - Family join requests
70. `family_statistics` - Family statistics

### Store System
71. `store_items` - Store item definitions
72. `store_categories` - Store categories
73. `user_purchases` - User purchase records
74. `user_inventory` - User inventory
75. `item_types` - Item type definitions

### Badge & Frame System
76. `badges` - Badge definitions
77. `badge_categories` - Badge categories
78. `user_badges` - User badge ownership
79. `frames` - Frame definitions
80. `frame_categories` - Frame categories
81. `user_frames` - User frame ownership

### Vehicle System
82. `vehicles` - Vehicle definitions
83. `vehicle_categories` - Vehicle categories
84. `user_vehicles` - User vehicle ownership

### Event System
85. `events` - Event definitions
86. `event_participants` - Event participants
87. `event_rewards` - Event rewards
88. `user_event_progress` - User event progress

### Task System
89. `tasks` - Task definitions
90. `task_categories` - Task categories
91. `user_tasks` - User task progress
92. `task_rewards` - Task rewards

### Game System
93. `games` - Game definitions
94. `game_sessions` - Game session records
95. `game_results` - Game results
96. `user_game_statistics` - User game statistics

### Notification System
97. `notifications` - Notification records
98. `notification_types` - Notification type definitions
99. `notification_settings` - User notification preferences
100. `notification_templates` - Notification templates

### Support System
101. `support_tickets` - Support ticket records
102. `support_messages` - Support ticket messages
103. `support_categories` - Support categories
104. `support_priorities` - Support priority definitions

### Report System
105. `reports` - User reports
106. `report_categories` - Report categories
107. `report_statuses` - Report status definitions
108. `report_actions` - Report action records

### CV System
109. `user_cvs` - User CV records
110. `cv_sections` - CV section definitions
111. `cv_experiences` - CV experience records
112. `cv_educations` - CV education records
113. `cv_skills` - CV skill records

### Admin System
114. `admin_users` - Admin user records
115. `admin_roles` - Admin role definitions
116. `admin_permissions` - Admin permissions
117. `admin_audit_logs` - Admin audit logs
118. `system_settings` - System-wide settings

### System Tables
119. `countries` - Country definitions
120. `currencies` - Currency definitions
121. `languages` - Language definitions
122. `timezones` - Timezone definitions
123. `app_versions` - App version records
124. `maintenance_windows` - Maintenance window records
125. `schema_versions` - Schema version tracking
126. `rate_limits` - Rate limiting rules
127. `rate_limit_logs` - Rate limit violation logs
128. `fraud_scores` - Fraud detection scores
129. `fraud_alerts` - Fraud alert records
130. `data_retention_policies` - Data retention policy definitions
131. `data_archival_logs` - Data archival tracking

---

## Table Purposes

### Core User Tables

**users**
- Primary user account information
- Authentication credentials
- Basic profile data
- Account status and metadata

**user_profiles**
- Extended profile information
- Personal details
- Social media links
- Bio and description

**user_settings**
- Application settings
- Theme preferences
- Notification preferences
- Privacy settings

**user_preferences**
- User-specific preferences
- Custom configurations
- Feature toggles
- Behavioral preferences

**user_sessions**
- Active session tracking
- Session tokens
- Device information
- Login/logout timestamps

**user_devices**
- Registered devices
- Device tokens for push notifications
- Device metadata
- Device trust status

**user_verifications**
- Verification status tracking
- Phone verification
- Email verification
- Identity verification

### Authentication & Security

**auth_providers**
- External authentication providers (Google, Apple, Facebook)
- Provider configurations
- OAuth settings

**user_auth_providers**
- User links to external providers
- Provider-specific user IDs
- Connection status

**password_resets**
- Password reset tokens
- Reset expiration
- Reset usage tracking

**two_factor_auth**
- 2FA settings
- Secret keys
- Backup codes
- 2FA method preferences

**security_logs**
- Security event logging
- Login attempts
- Password changes
- Suspicious activities

**blocked_users**
- User blocking relationships
- Block reasons
- Block timestamps
- Block expiration

### Wallet & Financial

**wallets**
- User wallet accounts
- Balance tracking
- Currency information
- Wallet status

**wallet_transactions**
- Transaction history
- Debit/credit records
- Transaction metadata
- Transaction status

**wallet_transaction_types**
- Transaction type definitions
- Transaction categories
- Transaction rules

**recharge_packages**
- Available recharge packages
- Pricing information
- Bonus amounts
- Package validity

**user_recharges**
- User recharge records
- Payment method
- Transaction status
- Recharge timestamps

**withdrawal_requests**
- Withdrawal request records
- Amount and destination
- Processing status
- Approval workflow

**withdrawal_methods**
- Available withdrawal methods
- Method configurations
- Processing rules
- Fee structures

**wallet_balance_snapshots**
- Wallet balance history for audit
- Balance snapshots at transaction time
- Historical balance tracking
- Financial audit trail

**transaction_reconciliations**
- Transaction reconciliation records
- Reconciliation status
- Discrepancy tracking
- Audit verification

**currency_exchange_rates**
- Currency exchange rate history
- Rate timestamps
- Source currency
- Target currency
- Rate values

**currency_conversions**
- Currency conversion tracking
- Conversion amounts
- Conversion fees
- Exchange rate used
- Conversion audit trail

### Agency System

**agencies**
- Agency information
- Agency details
- Agency status
- Agency settings

**agency_members**
- Agency membership records
- Member roles
- Join dates
- Membership status

**agency_roles**
- Agency role definitions
- Role permissions
- Role hierarchy
- Role capabilities

**agency_permissions**
- Granular agency permissions
- Permission definitions
- Permission groups

**agency_commissions**
- Commission structures
- Commission rates
- Commission rules
- Commission calculations

**agency_statistics**
- Agency performance metrics
- Member counts
- Revenue tracking
- Activity statistics

**recharge_agencies**
- Recharge agency information
- Agency locations
- Contact information
- Operating hours

**recharge_agency_rates**
- Recharge agency rates
- Commission percentages
- Rate tiers
- Rate validity

**recharge_agency_transactions**
- Recharge agency transactions
- Transaction records
- Commission tracking
- Performance metrics

### Room System

**rooms**
- Chat room information
- Room settings
- Room metadata
- Room status

**room_types**
- Room type definitions
- Type-specific rules
- Type capabilities

**room_categories**
- Room categorization
- Category metadata
- Category ordering

**room_members**
- Room membership records
- Member roles
- Join timestamps
- Membership status

**room_roles**
- Room role definitions
- Role permissions
- Role hierarchy

**room_settings**
- Room-specific settings
- Custom configurations
- Feature toggles

**room_statistics**
- Room usage statistics
- Member counts
- Activity metrics
- Popular rooms tracking

**room_bans**
- Room ban records
- Ban reasons
- Ban duration
- Ban issuer

**room_mutes**
- Room mute records
- Mute reasons
- Mute duration
- Mute issuer

### Messaging System

**messages**
- Message records
- Message content
- Message metadata
- Message status

**message_types**
- Message type definitions
- Type-specific rules
- Type capabilities

**message_reactions**
- Message reactions
- Reaction types
- Reaction counts

**message_pins**
- Pinned messages
- Pin metadata
- Pin expiration

**message_reads**
- Message read receipts
- Read timestamps
- Read status

**message_deletions**
- Message deletion records
- Deletion metadata
- Deletion tracking

**conversations**
- Conversation metadata
- Conversation settings
- Conversation status

**conversation_participants**
- Conversation participants
- Participant roles
- Join timestamps

### Gift System

**gifts**
- Gift definitions
- Gift metadata
- Gift pricing
- Gift availability

**gift_categories**
- Gift categorization
- Category metadata
- Category ordering

**gift_tiers**
- Gift tier definitions
- Tier pricing
- Tier benefits

**user_gifts**
- User gift inventory
- Gift ownership
- Gift quantities
- Gift expiration

**gift_transactions**
- Gift transaction records (consolidated)
- Sender information
- Recipient information
- Gift details
- Transaction timestamps
- Transaction status

**gift_statistics**
- Gift usage statistics
- Popular gifts
- Gift trends
- Revenue tracking

### VIP System

**vip_tiers**
- VIP tier definitions
- Tier benefits
- Tier pricing
- Tier requirements

**vip_benefits**
- VIP tier benefits
- Benefit descriptions
- Benefit values
- Benefit conditions

**user_vip_subscriptions**
- User VIP subscriptions
- Subscription status
- Subscription tier
- Subscription period

**vip_purchase_history**
- VIP purchase records
- Purchase details
- Payment information
- Purchase timestamps

### Ranking & Level System

**levels**
- User level definitions
- Level requirements
- Level rewards
- Level progression

**level_rewards**
- Level reward definitions
- Reward types
- Reward values
- Reward conditions

**user_levels**
- User level progress
- Current level
- Experience points
- Level history

**rankings**
- Ranking definitions
- Ranking types
- Ranking rules
- Ranking periods

**ranking_categories**
- Ranking categorization
- Category metadata
- Category rules

**user_rankings**
- User ranking positions
- Ranking scores
- Ranking history
- Ranking changes

**ranking_history**
- Historical ranking data
- Ranking snapshots
- Ranking trends

### Family System

**families**
- Family information
- Family details
- Family settings
- Family status

**family_members**
- Family membership records
- Member roles
- Join dates
- Membership status

**family_roles**
- Family role definitions
- Role permissions
- Role hierarchy

**family_settings**
- Family-specific settings
- Custom configurations
- Family rules

**family_requests**
- Family join requests
- Request status
- Request metadata
- Request timestamps

**family_statistics**
- Family statistics
- Member counts
- Activity metrics
- Family performance

### Store System

**store_items**
- Store item definitions
- Item metadata
- Item pricing
- Item availability

**store_categories**
- Store categorization
- Category metadata
- Category ordering

**user_purchases**
- User purchase records
- Purchase details
- Payment information
- Purchase timestamps

**user_inventory**
- User inventory
- Item ownership
- Item quantities
- Item expiration

**item_types**
- Item type definitions
- Type-specific rules
- Type capabilities

### Badge & Frame System

**badges**
- Badge definitions
- Badge metadata
- Badge requirements
- Badge availability

**badge_categories**
- Badge categorization
- Category metadata
- Category ordering

**user_badges**
- User badge ownership
- Badge acquisition
- Badge display
- Badge expiration

**frames**
- Frame definitions
- Frame metadata
- Frame pricing
- Frame availability

**frame_categories**
- Frame categorization
- Category metadata
- Category ordering

**user_frames**
- User frame ownership
- Frame acquisition
- Frame display
- Frame expiration

### Vehicle System

**vehicles**
- Vehicle definitions
- Vehicle metadata
- Vehicle pricing
- Vehicle availability

**vehicle_categories**
- Vehicle categorization
- Category metadata
- Category ordering

**user_vehicles**
- User vehicle ownership
- Vehicle acquisition
- Vehicle display
- Vehicle expiration

### Event System

**events**
- Event definitions
- Event metadata
- Event schedule
- Event rules

**event_participants**
- Event participation records
- Participant status
- Participation progress

**event_rewards**
- Event reward definitions
- Reward types
- Reward values
- Reward conditions

**user_event_progress**
- User event progress
- Progress tracking
- Achievement tracking
- Reward claiming

### Task System

**tasks**
- Task definitions
- Task requirements
- Task rewards
- Task availability

**task_categories**
- Task categorization
- Category metadata
- Category ordering

**user_tasks**
- User task progress
- Task completion
- Task rewards
- Task history

**task_rewards**
- Task reward definitions
- Reward types
- Reward values
- Reward conditions

### Game System

**games**
- Game definitions
- Game rules
- Game settings
- Game availability

**game_sessions**
- Game session records
- Session participants
- Session results
- Session duration

**game_results**
- Game result records
- Player scores
- Game outcomes
- Result metadata

**user_game_statistics**
- User game statistics
- Win/loss records
- Performance metrics
- Game history

### Notification System

**notifications**
- Notification records
- Notification content
- Notification metadata
- Delivery status

**notification_types**
- Notification type definitions
- Type-specific rules
- Delivery preferences

**notification_settings**
- User notification preferences
- Channel preferences
- Type preferences

**notification_templates**
- Notification templates
- Template content
- Template variables
- Template localization

### Support System

**support_tickets**
- Support ticket records
- Ticket details
- Ticket status
- Ticket priority

**support_messages**
- Support ticket messages
- Message content
- Sender information
- Message timestamps

**support_categories**
- Support categorization
- Category metadata
- Category routing

**support_priorities**
- Support priority definitions
- Priority levels
- Priority rules
- SLA definitions

### Report System

**reports**
- User report records
- Report details
- Report status
- Report priority

**report_categories**
- Report categorization
- Category metadata
- Category rules

**report_statuses**
- Report status definitions
- Status workflow
- Status transitions

**report_actions**
- Report action records
- Action details
- Action timestamps
- Action performers

### CV System

**user_cvs**
- User CV records
- CV metadata
- CV status
- CV visibility

**cv_sections**
- CV section definitions
- Section ordering
- Section requirements

**cv_experiences**
- CV experience records
- Work experience
- Company information
- Duration

**cv_educations**
- CV education records
- Education details
- Institution information
- Graduation date

**cv_skills**
- CV skill records
- Skill names
- Skill levels
- Skill categories

### Admin System

**admin_users**
- Admin user records
- Admin credentials
- Admin roles
- Admin permissions

**admin_roles**
- Admin role definitions
- Role permissions
- Role hierarchy
- Role capabilities

**admin_permissions**
- Admin permissions
- Permission definitions
- Permission groups
- Permission scope

**admin_audit_logs**
- Admin audit logs
- Action records
- Action timestamps
- Action performers

**system_settings**
- System-wide settings
- Configuration values
- Feature flags
- System parameters

### System Tables

**countries**
- Country definitions
- Country codes
- Country names
- Country metadata

**currencies**
- Currency definitions
- Currency codes
- Currency symbols
- Exchange rates

**languages**
- Language definitions
- Language codes
- Language names
- Language metadata

**timezones**
- Timezone definitions
- Timezone codes
- Timezone offsets
- DST rules

**app_versions**
- App version records
- Version numbers
- Release dates
- Version metadata

**maintenance_windows**
- Maintenance window records
- Schedule information
- Maintenance type
- Impact scope

**schema_versions**
- Schema version tracking
- Migration history
- Version timestamps
- Rollback information

**rate_limits**
- Rate limiting rules
- Rate limits per endpoint
- Time windows
- Limit thresholds

**rate_limit_logs**
- Rate limit violation logs
- Violation timestamps
- User identification
- Violation details

**fraud_scores**
- Fraud detection scores
- User risk scoring
- Score calculation details
- Score timestamps

**fraud_alerts**
- Fraud alert records
- Alert severity
- Alert details
- Resolution status

**data_retention_policies**
- Data retention policy definitions
- Retention periods
- Data types
- Archival rules

**data_archival_logs**
- Data archival tracking
- Archival timestamps
- Data ranges
- Archival status

---

## Relationships

### User Relationships

**users** is the central entity with relationships to:
- user_profiles (1:1)
- user_settings (1:1)
- user_preferences (1:1)
- wallets (1:1)
- user_sessions (1:N)
- user_devices (1:N)
- user_verifications (1:N)
- user_auth_providers (1:N)
- blocked_users (1:N as blocker)
- blocked_users (1:N as blocked)
- room_members (1:N)
- messages (1:N)
- gift_transactions (1:N)
- user_vip_subscriptions (1:N)
- user_levels (1:1)
- user_rankings (1:N)
- family_members (1:N)
- user_purchases (1:N)
- user_inventory (1:N)
- user_badges (1:N)
- user_frames (1:N)
- user_vehicles (1:N)
- notifications (1:N)
- support_tickets (1:N)
- reports (1:N)
- user_cvs (1:1)
- agency_members (1:N)

### Wallet Relationships

**wallets** has relationships to:
- users (1:1)
- wallet_transactions (1:N)

**wallet_transactions** has relationships to:
- wallets (N:1)
- wallet_transaction_types (N:1)
- recharge_packages (N:1, optional)
- withdrawal_requests (N:1, optional)
- wallet_balance_snapshots (N:1)
- transaction_reconciliations (N:1)
- currency_conversions (N:1, optional)

### Agency Relationships

**agencies** has relationships to:
- agency_members (1:N)
- agency_statistics (1:1)
- recharge_agencies (1:1, optional)

**agency_members** has relationships to:
- agencies (N:1)
- users (N:1)
- agency_roles (N:1)

**recharge_agencies** has relationships to:
- agencies (N:1)
- recharge_agency_rates (1:N)
- recharge_agency_transactions (1:N)

### Room Relationships

**rooms** has relationships to:
- room_types (N:1)
- room_categories (N:1)
- room_members (1:N)
- room_settings (1:1)
- room_statistics (1:1)
- room_bans (1:N)
- room_mutes (1:N)

**room_members** has relationships to:
- rooms (N:1)
- users (N:1)
- room_roles (N:1)

### Message Relationships

**messages** has relationships to:
- users (N:1 as sender)
- rooms (N:1, optional)
- conversations (N:1, optional)
- message_types (N:1)
- message_reactions (1:N)
- message_reads (1:N)
- message_deletions (1:N)

**conversations** has relationships to:
- conversation_participants (1:N)

**conversation_participants** has relationships to:
- conversations (N:1)
- users (N:1)

### Gift Relationships

**gifts** has relationships to:
- gift_categories (N:1)
- gift_tiers (N:1)
- user_gifts (1:N)
- gift_transactions (1:N)

**user_gifts** has relationships to:
- users (N:1)
- gifts (N:1)

**gift_transactions** has relationships to:
- users (N:1 as sender)
- users (N:1 as receiver)
- gifts (N:1)

### VIP Relationships

**vip_tiers** has relationships to:
- vip_benefits (1:N)
- user_vip_subscriptions (1:N)

**user_vip_subscriptions** has relationships to:
- users (N:1)
- vip_tiers (N:1)
- vip_purchase_history (1:N)

### Family Relationships

**families** has relationships to:
- family_members (1:N)
- family_settings (1:1)
- family_statistics (1:1)

**family_members** has relationships to:
- families (N:1)
- users (N:1)
- family_roles (N:1)

### Store Relationships

**store_items** has relationships to:
- store_categories (N:1)
- item_types (N:1)
- user_purchases (1:N)
- user_inventory (1:N)

**user_inventory** has relationships to:
- users (N:1)
- store_items (N:1)

### Badge & Frame Relationships

**badges** has relationships to:
- badge_categories (N:1)
- user_badges (1:N)

**user_badges** has relationships to:
- users (N:1)
- badges (N:1)

**frames** has relationships to:
- frame_categories (N:1)
- user_frames (1:N)

**user_frames** has relationships to:
- users (N:1)
- frames (N:1)

### Vehicle Relationships

**vehicles** has relationships to:
- vehicle_categories (N:1)
- user_vehicles (1:N)

**user_vehicles** has relationships to:
- users (N:1)
- vehicles (N:1)

### Event Relationships

**events** has relationships to:
- event_participants (1:N)
- event_rewards (1:N)

**event_participants** has relationships to:
- events (N:1)
- users (N:1)

**user_event_progress** has relationships to:
- events (N:1)
- users (N:1)

### Task Relationships

**tasks** has relationships to:
- task_categories (N:1)
- task_rewards (1:N)
- user_tasks (1:N)

**user_tasks** has relationships to:
- tasks (N:1)
- users (N:1)

### Game Relationships

**games** has relationships to:
- game_sessions (1:N)

**game_sessions** has relationships to:
- games (N:1)
- game_results (1:N)

**user_game_statistics** has relationships to:
- users (N:1)
- games (N:1)

### Notification Relationships

**notifications** has relationships to:
- users (N:1 as recipient)
- notification_types (N:1)
- notification_templates (N:1, optional)

**notification_settings** has relationships to:
- users (N:1)
- notification_types (N:1)

### Support Relationships

**support_tickets** has relationships to:
- users (N:1)
- support_categories (N:1)
- support_priorities (N:1)
- support_messages (1:N)

**support_messages** has relationships to:
- support_tickets (N:1)
- users (N:1)

### Report Relationships

**reports** has relationships to:
- users (N:1 as reporter)
- users (N:1 as reported, optional)
- report_categories (N:1)
- report_statuses (N:1)
- report_actions (1:N)

---

## Primary Keys

All tables use UUID primary keys for scalability and distributed system compatibility:

- `id` (UUID) - Primary key for all tables
- Composite primary keys for junction tables:
  - `user_auth_providers`: (user_id, provider_id)
  - `agency_members`: (agency_id, user_id)
  - `room_members`: (room_id, user_id)
  - `conversation_participants`: (conversation_id, user_id)
  - `family_members`: (family_id, user_id)
  - `event_participants`: (event_id, user_id)

---

## Foreign Keys

### Core User Foreign Keys
- `user_profiles.user_id` → `users.id`
- `user_settings.user_id` → `users.id`
- `user_preferences.user_id` → `users.id`
- `user_sessions.user_id` → `users.id`
- `user_devices.user_id` → `users.id`
- `user_verifications.user_id` → `users.id`

### Authentication Foreign Keys
- `user_auth_providers.user_id` → `users.id`
- `user_auth_providers.provider_id` → `auth_providers.id`
- `password_resets.user_id` → `users.id`
- `two_factor_auth.user_id` → `users.id`
- `blocked_users.blocker_id` → `users.id`
- `blocked_users.blocked_id` → `users.id`

### Wallet Foreign Keys
- `wallets.user_id` → `users.id`
- `wallet_transactions.wallet_id` → `wallets.id`
- `wallet_transactions.transaction_type_id` → `wallet_transaction_types.id`
- `wallet_transactions.recharge_package_id` → `recharge_packages.id` (nullable)
- `wallet_transactions.withdrawal_request_id` → `withdrawal_requests.id` (nullable)
- `wallet_balance_snapshots.wallet_id` → `wallets.id`
- `wallet_balance_snapshots.transaction_id` → `wallet_transactions.id`
- `transaction_reconciliations.transaction_id` → `wallet_transactions.id`
- `currency_exchange_rates.source_currency_id` → `currencies.id`
- `currency_exchange_rates.target_currency_id` → `currencies.id`
- `currency_conversions.transaction_id` → `wallet_transactions.id`
- `currency_conversions.exchange_rate_id` → `currency_exchange_rates.id`
- `user_recharges.user_id` → `users.id`
- `user_recharges.recharge_package_id` → `recharge_packages.id`
- `withdrawal_requests.user_id` → `users.id`
- `withdrawal_requests.withdrawal_method_id` → `withdrawal_methods.id`

### Agency Foreign Keys
- `agency_members.agency_id` → `agencies.id`
- `agency_members.user_id` → `users.id`
- `agency_members.role_id` → `agency_roles.id`
- `recharge_agencies.agency_id` → `agencies.id`
- `recharge_agency_rates.recharge_agency_id` → `recharge_agencies.id`
- `recharge_agency_transactions.recharge_agency_id` → `recharge_agencies.id`

### Room Foreign Keys
- `rooms.type_id` → `room_types.id`
- `rooms.category_id` → `room_categories.id`
- `room_members.room_id` → `rooms.id`
- `room_members.user_id` → `users.id`
- `room_members.role_id` → `room_roles.id`
- `room_bans.room_id` → `rooms.id`
- `room_bans.user_id` → `users.id`
- `room_bans.banned_by` → `users.id`
- `room_mutes.room_id` → `rooms.id`
- `room_mutes.user_id` → `users.id`
- `room_mutes.muted_by` → `users.id`

### Message Foreign Keys
- `messages.sender_id` → `users.id`
- `messages.room_id` → `rooms.id` (nullable)
- `messages.conversation_id` → `conversations.id` (nullable)
- `messages.type_id` → `message_types.id`
- `message_reactions.message_id` → `messages.id`
- `message_reactions.user_id` → `users.id`
- `message_pins.message_id` → `messages.id`
- `message_pins.pinned_by` → `users.id`
- `message_reads.message_id` → `messages.id`
- `message_reads.user_id` → `users.id`
- `message_deletions.message_id` → `messages.id`
- `message_deletions.deleted_by` → `users.id`
- `conversation_participants.conversation_id` → `conversations.id`
- `conversation_participants.user_id` → `users.id`

### Gift Foreign Keys
- `gifts.category_id` → `gift_categories.id`
- `gifts.tier_id` → `gift_tiers.id`
- `user_gifts.user_id` → `users.id`
- `user_gifts.gift_id` → `gifts.id`
- `gift_transactions.sender_id` → `users.id`
- `gift_transactions.receiver_id` → `users.id`
- `gift_transactions.gift_id` → `gifts.id`

### VIP Foreign Keys
- `user_vip_subscriptions.user_id` → `users.id`
- `user_vip_subscriptions.vip_tier_id` → `vip_tiers.id`
- `vip_purchase_history.subscription_id` → `user_vip_subscriptions.id`

### Family Foreign Keys
- `family_members.family_id` → `families.id`
- `family_members.user_id` → `users.id`
- `family_members.role_id` → `family_roles.id`
- `family_requests.family_id` → `families.id`
- `family_requests.user_id` → `users.id`

### Store Foreign Keys
- `store_items.category_id` → `store_categories.id`
- `store_items.item_type_id` → `item_types.id`
- `user_purchases.user_id` → `users.id`
- `user_purchases.store_item_id` → `store_items.id`
- `user_inventory.user_id` → `users.id`
- `user_inventory.store_item_id` → `store_items.id`

### Badge & Frame Foreign Keys
- `badges.category_id` → `badge_categories.id`
- `user_badges.user_id` → `users.id`
- `user_badges.badge_id` → `badges.id`
- `frames.category_id` → `frame_categories.id`
- `user_frames.user_id` → `users.id`
- `user_frames.frame_id` → `frames.id`

### Vehicle Foreign Keys
- `vehicles.category_id` → `vehicle_categories.id`
- `user_vehicles.user_id` → `users.id`
- `user_vehicles.vehicle_id` → `vehicles.id`

### Event Foreign Keys
- `event_participants.event_id` → `events.id`
- `event_participants.user_id` → `users.id`
- `user_event_progress.event_id` → `events.id`
- `user_event_progress.user_id` → `users.id`

### Task Foreign Keys
- `tasks.category_id` → `task_categories.id`
- `user_tasks.user_id` → `users.id`
- `user_tasks.task_id` → `tasks.id`

### Game Foreign Keys
- `game_sessions.game_id` → `games.id`
- `game_results.session_id` → `game_sessions.id`
- `user_game_statistics.user_id` → `users.id`
- `user_game_statistics.game_id` → `games.id`

### Notification Foreign Keys
- `notifications.user_id` → `users.id`
- `notifications.type_id` → `notification_types.id`
- `notifications.template_id` → `notification_templates.id` (nullable)
- `notification_settings.user_id` → `users.id`
- `notification_settings.type_id` → `notification_types.id`

### Support Foreign Keys
- `support_tickets.user_id` → `users.id`
- `support_tickets.category_id` → `support_categories.id`
- `support_tickets.priority_id` → `support_priorities.id`
- `support_messages.ticket_id` → `support_tickets.id`
- `support_messages.user_id` → `users.id`

### Report Foreign Keys
- `reports.reporter_id` → `users.id`
- `reports.reported_id` → `users.id` (nullable)
- `reports.category_id` → `report_categories.id`
- `reports.status_id` → `report_statuses.id`
- `report_actions.report_id` → `reports.id`
- `report_actions.performed_by` → `users.id`

### CV Foreign Keys
- `user_cvs.user_id` → `users.id`
- `cv_experiences.cv_id` → `user_cvs.id`
- `cv_educations.cv_id` → `user_cvs.id`
- `cv_skills.cv_id` → `user_cvs.id`

### Admin Foreign Keys
- `admin_audit_logs.admin_user_id` → `admin_users.id`

### System Foreign Keys
- `rate_limits.user_id` → `users.id` (nullable)
- `rate_limit_logs.rate_limit_id` → `rate_limits.id`
- `rate_limit_logs.user_id` → `users.id`
- `fraud_scores.user_id` → `users.id`
- `fraud_alerts.fraud_score_id` → `fraud_scores.id`
- `fraud_alerts.user_id` → `users.id`
- `data_retention_policies.table_name` → (system table reference)
- `data_archival_logs.retention_policy_id` → `data_retention_policies.id`

---

## One-to-One Relations

1. **users ↔ user_profiles** - Each user has one extended profile
2. **users ↔ user_settings** - Each user has one settings record
3. **users ↔ user_preferences** - Each user has one preferences record
4. **users ↔ wallets** - Each user has one wallet
5. **users ↔ user_levels** - Each user has one level record
6. **users ↔ user_cvs** - Each user has one CV record
7. **agencies ↔ agency_statistics** - Each agency has one statistics record
8. **agencies ↔ recharge_agencies** - Each agency can have one recharge agency record
9. **rooms ↔ room_settings** - Each room has one settings record
10. **rooms ↔ room_statistics** - Each room has one statistics record
11. **families ↔ family_settings** - Each family has one settings record
12. **families ↔ family_statistics** - Each family has one statistics record

---

## One-to-Many Relations

### User One-to-Many
1. **users → user_sessions** - One user has many sessions
2. **users → user_devices** - One user has many devices
3. **users → user_verifications** - One user has many verification records
4. **users → user_auth_providers** - One user can have many auth providers
5. **users → blocked_users** (as blocker) - One user can block many users
6. **users → blocked_users** (as blocked) - One user can be blocked by many users
7. **users → room_members** - One user can be in many rooms
8. **users → messages** (as sender) - One user can send many messages
9. **users → gift_sends** - One user can send many gifts
10. **users → gift_receives** - One user can receive many gifts
11. **users → user_vip_subscriptions** - One user can have many VIP subscriptions
12. **users → user_rankings** - One user can have many ranking records
13. **users → family_members** - One user can be in many families
14. **users → user_purchases** - One user can make many purchases
15. **users → user_inventory** - One user can have many inventory items
16. **users → user_badges** - One user can have many badges
17. **users → user_frames** - One user can have many frames
18. **users → user_vehicles** - One user can have many vehicles
19. **users → notifications** - One user can receive many notifications
20. **users → support_tickets** - One user can create many support tickets
21. **users → reports** (as reporter) - One user can report many users
22. **users → reports** (as reported) - One user can be reported by many users
23. **users → agency_members** - One user can be in many agencies

### Wallet One-to-Many
1. **wallets → wallet_transactions** - One wallet has many transactions

### Agency One-to-Many
1. **agencies → agency_members** - One agency has many members
2. **agencies → recharge_agency_rates** - One recharge agency has many rate records
3. **agencies → recharge_agency_transactions** - One recharge agency has many transactions

### Room One-to-Many
1. **rooms → room_members** - One room has many members
2. **rooms → room_bans** - One room has many bans
3. **rooms → room_mutes** - One room has many mutes
4. **rooms → messages** - One room has many messages

### Message One-to-Many
1. **messages → message_reactions** - One message has many reactions
2. **messages → message_reads** - One message has many read receipts
3. **messages → message_deletions** - One message can have deletion records

### Gift One-to-Many
1. **gifts → user_gifts** - One gift can be owned by many users
2. **gifts → gift_sends** - One gift can be sent many times
3. **gifts → gift_receives** - One gift can be received many times

### VIP One-to-Many
1. **vip_tiers → vip_benefits** - One VIP tier has many benefits
2. **vip_tiers → user_vip_subscriptions** - One VIP tier can have many subscriptions
3. **user_vip_subscriptions → vip_purchase_history** - One subscription has many purchase records

### Family One-to-Many
1. **families → family_members** - One family has many members
2. **families → family_requests** - One family has many join requests

### Store One-to-Many
1. **store_items → user_purchases** - One item can be purchased many times
2. **store_items → user_inventory** - One item can be in many inventories

### Badge One-to-Many
1. **badges → user_badges** - One badge can be owned by many users

### Frame One-to-Many
1. **frames → user_frames** - One frame can be owned by many users

### Vehicle One-to-Many
1. **vehicles → user_vehicles** - One vehicle can be owned by many users

### Event One-to-Many
1. **events → event_participants** - One event has many participants
2. **events → event_rewards** - One event has many rewards

### Task One-to-Many
1. **tasks → user_tasks** - One task can be completed by many users
2. **tasks → task_rewards** - One task has many rewards

### Game One-to-Many
1. **games → game_sessions** - One game has many sessions
2. **game_sessions → game_results** - One session has many results

### Notification One-to-Many
1. **users → notifications** - One user receives many notifications

### Support One-to-Many
1. **support_tickets → support_messages** - One ticket has many messages

### Report One-to-Many
1. **reports → report_actions** - One report has many actions

### CV One-to-Many
1. **user_cvs → cv_experiences** - One CV has many experiences
2. **user_cvs → cv_educations** - One CV has many educations
3. **user_cvs → cv_skills** - One CV has many skills

---

## Many-to-Many Relations

### Agency Members
- **agencies ↔ users** via `agency_members`
- One agency can have many users
- One user can be in many agencies

### Room Members
- **rooms ↔ users** via `room_members`
- One room can have many users
- One user can be in many rooms

### Conversation Participants
- **conversations ↔ users** via `conversation_participants`
- One conversation can have many participants
- One user can be in many conversations

### Family Members
- **families ↔ users** via `family_members`
- One family can have many users
- One user can be in many families

### Event Participants
- **events ↔ users** via `event_participants`
- One event can have many participants
- One user can participate in many events

---

## Suggested Indexes

### User Tables
- `users.email` (unique)
- `users.username` (unique)
- `users.phone` (unique)
- `users.status`
- `users.created_at`
- `user_sessions.user_id`
- `user_sessions.token`
- `user_sessions.expires_at`
- `user_devices.user_id`
- `user_devices.device_token`
- `blocked_users.blocker_id`
- `blocked_users.blocked_id`

### Wallet Tables
- `wallets.user_id` (unique)
- `wallet_transactions.wallet_id`
- `wallet_transactions.created_at`
- `wallet_transactions.transaction_type_id`
- `user_recharges.user_id`
- `user_recharges.created_at`
- `withdrawal_requests.user_id`
- `withdrawal_requests.status`
- `withdrawal_requests.created_at`

### Agency Tables
- `agency_members.agency_id`
- `agency_members.user_id`
- `agency_members.role_id`
- `recharge_agency_transactions.recharge_agency_id`
- `recharge_agency_transactions.created_at`

### Room Tables
- `rooms.name`
- `rooms.category_id`
- `rooms.status`
- `rooms.created_at`
- `room_members.room_id`
- `room_members.user_id`
- `room_members.role_id`
- `room_bans.room_id`
- `room_bans.user_id`
- `room_bans.expires_at`
- `room_mutes.room_id`
- `room_mutes.user_id`
- `room_mutes.expires_at`

### Message Tables
- `messages.sender_id`
- `messages.room_id`
- `messages.conversation_id`
- `messages.created_at`
- `message_reactions.message_id`
- `message_reactions.user_id`
- `message_reads.message_id`
- `message_reads.user_id`

### Gift Tables
- `gifts.category_id`
- `gifts.tier_id`
- `user_gifts.user_id`
- `user_gifts.gift_id`
- `gift_sends.sender_id`
- `gift_sends.created_at`
- `gift_receives.receiver_id`
- `gift_receives.created_at`

### VIP Tables
- `user_vip_subscriptions.user_id`
- `user_vip_subscriptions.vip_tier_id`
- `user_vip_subscriptions.status`
- `user_vip_subscriptions.expires_at`

### Family Tables
- `family_members.family_id`
- `family_members.user_id`
- `family_members.role_id`
- `family_requests.family_id`
- `family_requests.user_id`
- `family_requests.status`

### Store Tables
- `store_items.category_id`
- `store_items.item_type_id`
- `user_purchases.user_id`
- `user_purchases.store_item_id`
- `user_inventory.user_id`
- `user_inventory.store_item_id`

### Badge & Frame Tables
- `user_badges.user_id`
- `user_badges.badge_id`
- `user_frames.user_id`
- `user_frames.frame_id`

### Vehicle Tables
- `user_vehicles.user_id`
- `user_vehicles.vehicle_id`

### Event Tables
- `event_participants.event_id`
- `event_participants.user_id`
- `user_event_progress.event_id`
- `user_event_progress.user_id`

### Task Tables
- `user_tasks.user_id`
- `user_tasks.task_id`
- `user_tasks.status`

### Game Tables
- `game_sessions.game_id`
- `game_sessions.created_at`
- `user_game_statistics.user_id`
- `user_game_statistics.game_id`

### Notification Tables
- `notifications.user_id`
- `notifications.type_id`
- `notifications.created_at`
- `notifications.read`
- `notification_settings.user_id`
- `notification_settings.type_id`

### Support Tables
- `support_tickets.user_id`
- `support_tickets.category_id`
- `support_tickets.status`
- `support_tickets.created_at`
- `support_messages.ticket_id`
- `support_messages.created_at`

### Report Tables
- `reports.reporter_id`
- `reports.reported_id`
- `reports.category_id`
- `reports.status_id`
- `reports.created_at`

### CV Tables
- `user_cvs.user_id` (unique)
- `cv_experiences.cv_id`
- `cv_educations.cv_id`
- `cv_skills.cv_id`

### Composite Indexes
- `room_members(room_id, user_id)` (unique)
- `room_members(user_id, room_id)`
- `agency_members(agency_id, user_id)` (unique)
- `agency_members(user_id, agency_id)`
- `family_members(family_id, user_id)` (unique)
- `family_members(user_id, family_id)`
- `conversation_participants(conversation_id, user_id)` (unique)
- `event_participants(event_id, user_id)` (unique)
- `message_reads(message_id, user_id)` (unique)

---

## Storage Buckets

### User Content
- `avatars/` - User profile pictures
- `covers/` - User cover photos
- `media/` - User uploaded media

### Room Content
- `room_covers/` - Room cover images
- `room_media/` - Room-specific media

### Gift Content
- `gifts/` - Gift images and animations
- `gift_icons/` - Gift icon images

### Badge Content
- `badges/` - Badge images
- `badge_icons/` - Badge icon images

### Frame Content
- `frames/` - Frame images
- `frame_animations/` - Frame animations

### Vehicle Content
- `vehicles/` - Vehicle images
- `vehicle_animations/` - Vehicle animations

### Store Content
- `store_items/` - Store item images
- `store_thumbnails/` - Store item thumbnails

### System Content
- `app_icons/` - Application icons
- `logos/` - Brand logos
- `banners/` - Promotional banners

### Document Content
- `documents/` - User documents
- `cv_files/` - CV files
- `verification_docs/` - Verification documents

### Temporary Content
- `temp/` - Temporary uploads
- `cache/` - Cached content

---

## Enums

### User Status
- `active` - User is active
- `inactive` - User is inactive
- `suspended` - User is suspended
- `banned` - User is banned
- `deleted` - User is deleted

### User Role
- `user` - Regular user
- `moderator` - Moderator
- `admin` - Administrator
- `super_admin` - Super administrator

### Verification Status
- `unverified` - Not verified
- `pending` - Verification pending
- `verified` - Verified
- `rejected` - Verification rejected

### Transaction Type
- `credit` - Credit transaction
- `debit` - Debit transaction
- `refund` - Refund transaction
- `bonus` - Bonus transaction

### Transaction Status
- `pending` - Transaction pending
- `completed` - Transaction completed
- `failed` - Transaction failed
- `cancelled` - Transaction cancelled
- `refunded` - Transaction refunded

### Withdrawal Status
- `pending` - Withdrawal pending
- `processing` - Withdrawal processing
- `completed` - Withdrawal completed
- `rejected` - Withdrawal rejected
- `cancelled` - Withdrawal cancelled

### Agency Role
- `owner` - Agency owner
- `manager` - Agency manager
- `member` - Agency member
- `agent` - Agency agent

### Room Type
- `public` - Public room
- `private` - Private room
- `vip` - VIP room
- `agency` - Agency room
- `family` - Family room

### Room Role
- `owner` - Room owner
- `admin` - Room admin
- `moderator` - Room moderator
- `member` - Room member

### Message Type
- `text` - Text message
- `image` - Image message
- `audio` - Audio message
- `video` - Video message
- `gift` - Gift message
- `system` - System message

### Message Status
- `sent` - Message sent
- `delivered` - Message delivered
- `read` - Message read
- `deleted` - Message deleted

### VIP Tier
- `none` - No VIP
- `bronze` - Bronze VIP
- `silver` - Silver VIP
- `gold` - Gold VIP
- `platinum` - Platinum VIP
- `diamond` - Diamond VIP

### Family Role
- `owner` - Family owner
- `co_owner` - Family co-owner
- `admin` - Family admin
- `member` - Family member

### Notification Type
- `system` - System notification
- `message` - Message notification
- `gift` - Gift notification
- `room` - Room notification
- `family` - Family notification
- `agency` - Agency notification
- `wallet` - Wallet notification

### Notification Status
- `unread` - Unread notification
- `read` - Read notification
- `archived` - Archived notification

### Support Priority
- `low` - Low priority
- `medium` - Medium priority
- `high` - High priority
- `urgent` - Urgent priority

### Support Status
- `open` - Open ticket
- `in_progress` - Ticket in progress
- `resolved` - Resolved ticket
- `closed` - Closed ticket

### Report Status
- `pending` - Report pending
- `under_review` - Report under review
- `action_taken` - Action taken
- `rejected` - Report rejected
- `resolved` - Report resolved

### Report Category
- `harassment` - Harassment
- `spam` - Spam
- `inappropriate_content` - Inappropriate content
- `fraud` - Fraud
- `other` - Other

### Task Status
- `not_started` - Task not started
- `in_progress` - Task in progress
- `completed` - Task completed
- `failed` - Task failed

### Event Status
- `upcoming` - Event upcoming
- `ongoing` - Event ongoing
- `completed` - Event completed
- `cancelled` - Event cancelled

### Game Status
- `waiting` - Game waiting
- `in_progress` - Game in progress
- `completed` - Game completed
- `abandoned` - Game abandoned

---

## Row Level Security Strategy

### Security Principles

1. **User Isolation** - Users can only access their own data
2. **Role-Based Access** - Different roles have different access levels
3. **Context Awareness** - Security policies consider user context
4. **Data Minimization** - Only expose necessary data
5. **Audit Trail** - Log all data access

### RLS Policies by Table

#### User Tables
- **users**: Read own profile + public profile data
- **user_profiles**: Read own profile + public profile data
- **user_settings**: Read/write own settings only
- **user_preferences**: Read/write own preferences only
- **user_sessions**: Read/write own sessions only
- **user_devices**: Read/write own devices only
- **user_verifications**: Read/write own verifications only

#### Authentication Tables
- **user_auth_providers**: Read/write own provider links only
- **password_resets**: Read/write own reset tokens only
- **two_factor_auth**: Read/write own 2FA settings only
- **security_logs**: Admin read-only, user read own logs
- **blocked_users**: Read own blocks, write own blocks

#### Wallet Tables
- **wallets**: Read/write own wallet only
- **wallet_transactions**: Read own transactions, write own transactions
- **user_recharges**: Read/write own recharges only
- **withdrawal_requests**: Read/write own requests only, admin read all

#### Agency Tables
- **agencies**: Public read, agency members read/write own agency
- **agency_members**: Read own agency memberships, agency members read agency members
- **recharge_agencies**: Public read, agency members read/write own agency
- **recharge_agency_transactions**: Agency members read/write own agency transactions

#### Room Tables
- **rooms**: Public read for public rooms, members read/write own rooms
- **room_members**: Read own room memberships, room members read room members
- **room_bans**: Room admins read/write room bans
- **room_mutes**: Room admins read/write room mutes

#### Message Tables
- **messages**: Room members read room messages, conversation participants read conversation messages
- **message_reactions**: Read own reactions, write own reactions
- **message_reads**: Read/write own read receipts
- **message_deletions**: Admin read/write, user read own deletions

#### Gift Tables
- **gifts**: Public read
- **user_gifts**: Read/write own gifts only
- **gift_sends**: Read own sent gifts, write own sent gifts
- **gift_receives**: Read own received gifts

#### VIP Tables
- **vip_tiers**: Public read
- **user_vip_subscriptions**: Read/write own subscriptions only

#### Family Tables
- **families**: Public read for public families, members read/write own families
- **family_members**: Family members read family members
- **family_requests**: Read own requests, family admins read/write family requests

#### Store Tables
- **store_items**: Public read
- **user_purchases**: Read/write own purchases only
- **user_inventory**: Read/write own inventory only

#### Badge & Frame Tables
- **badges**: Public read
- **user_badges**: Read/write own badges only
- **frames**: Public read
- **user_frames**: Read/write own frames only

#### Vehicle Tables
- **vehicles**: Public read
- **user_vehicles**: Read/write own vehicles only

#### Notification Tables
- **notifications**: Read/write own notifications only
- **notification_settings**: Read/write own settings only

#### Support Tables
- **support_tickets**: Read/write own tickets only, support staff read assigned tickets
- **support_messages**: Ticket participants read ticket messages, write ticket messages

#### Report Tables
- **reports**: Read own reports as reporter, admin read all
- **report_actions**: Admin read/write only

#### CV Tables
- **user_cvs**: Read/write own CV only, public read if public
- **cv_experiences**: Read/write own experiences only
- **cv_educations**: Read/write own education only
- **cv_skills**: Read/write own skills only

#### Admin Tables
- **admin_users**: Admin read/write only
- **admin_audit_logs**: Admin read-only

### Security Functions

1. **is_owner()** - Check if user is the owner of a record
2. **is_member()** - Check if user is a member of a group
3. **is_admin()** - Check if user has admin role
4. **is_moderator()** - Check if user has moderator role
5. **has_permission()** - Check if user has specific permission
6. **is_public()** - Check if resource is public
7. **is_same_agency()** - Check if users are in same agency
8. **is_same_family()** - Check if users are in same family

---

## Authentication Flow

### Registration Flow

1. **User Registration**
   - User provides email/phone, username, password
   - System validates input
   - System creates user record in `users` table
   - System creates user profile in `user_profiles` table
   - System creates user settings in `user_settings` table
   - System creates user preferences in `user_preferences` table
   - System creates wallet in `wallets` table
   - System creates user level in `user_levels` table

2. **Email Verification**
   - System sends verification email
   - System creates verification record in `user_verifications` table
   - User clicks verification link
   - System updates verification status to `verified`
   - System updates user status to `active`

3. **Phone Verification** (Optional)
   - User provides phone number
   - System sends SMS verification code
   - User enters verification code
   - System creates verification record in `user_verifications` table
   - System updates verification status to `verified`

4. **External Provider Registration**
   - User selects external provider (Google, Apple, Facebook)
   - System redirects to provider
   - Provider authenticates user
   - System receives user data from provider
   - System creates user record if new user
   - System creates provider link in `user_auth_providers` table
   - System creates user profile, settings, preferences, wallet, level

### Login Flow

1. **Email/Password Login**
   - User provides email and password
   - System validates credentials
   - System creates session in `user_sessions` table
   - System returns session token
   - System logs login event in `security_logs` table

2. **External Provider Login**
   - User selects external provider
   - System redirects to provider
   - Provider authenticates user
   - System receives user data from provider
   - System checks if provider link exists in `user_auth_providers` table
   - System creates session in `user_sessions` table
   - System returns session token
   - System logs login event in `security_logs` table

3. **Two-Factor Authentication** (Optional)
   - User enters username/password
   - System validates credentials
   - System checks if 2FA is enabled in `two_factor_auth` table
   - System sends 2FA code
   - User enters 2FA code
   - System validates 2FA code
   - System creates session in `user_sessions` table
   - System returns session token

### Session Management

1. **Session Creation**
   - System creates session record in `user_sessions` table
   - System generates session token
   - System stores device information in `user_devices` table
   - System sets session expiration

2. **Session Validation**
   - System validates session token on each request
   - System checks session expiration
   - System checks device trust status
   - System logs session activity

3. **Session Termination**
   - User logs out
   - System updates session status
   - System logs logout event
   - System invalidates session token

### Password Reset Flow

1. **Password Reset Request**
   - User requests password reset
   - System validates email/phone
   - System creates reset token in `password_resets` table
   - System sends reset link/code
   - System logs reset request

2. **Password Reset**
   - User clicks reset link or enters code
   - System validates reset token
   - System checks token expiration
   - User enters new password
   - System updates password in `users` table
   - System invalidates reset token
   - System logs password change

### Security Logging

1. **Login Events**
   - Successful login
   - Failed login attempt
   - Login from new device
   - Login from unusual location

2. **Password Events**
   - Password change
   - Password reset request
   - Password reset completion

3. **Account Events**
   - Account creation
   - Account deletion
   - Account suspension
   - Account recovery

---

## Wallet System Flow

### Wallet Creation

1. **Initial Wallet Creation**
   - System creates wallet record in `wallets` table
   - System sets initial balance to 0
   - System sets currency based on user location
   - System sets wallet status to `active`

### Recharge Flow

1. **Recharge Package Selection**
   - User views available recharge packages from `recharge_packages` table
   - User selects recharge package
   - System displays package details and pricing

2. **Recharge Payment**
   - User selects payment method
   - System processes payment
   - System creates recharge record in `user_recharges` table
   - System creates transaction record in `wallet_transactions` table
   - System updates wallet balance
   - System applies bonus if applicable

3. **Recharge Agency Recharge**
   - User visits recharge agency
   - Agency processes recharge
   - System creates recharge record in `user_recharges` table
   - System creates agency transaction record in `recharge_agency_transactions` table
   - System calculates agency commission
   - System creates transaction record in `wallet_transactions` table
   - System updates wallet balance

### Withdrawal Flow

1. **Withdrawal Request**
   - User requests withdrawal
   - User selects withdrawal method from `withdrawal_methods` table
   - User enters withdrawal amount
   - System validates withdrawal amount
   - System checks wallet balance
   - System creates withdrawal request in `withdrawal_requests` table
   - System sets withdrawal status to `pending`

2. **Withdrawal Processing**
   - Admin reviews withdrawal request
   - Admin approves or rejects withdrawal
   - System updates withdrawal status
   - If approved, system processes withdrawal
   - System creates transaction record in `wallet_transactions` table
   - System updates wallet balance

### Transaction Flow

1. **Credit Transaction**
   - System creates transaction record in `wallet_transactions` table
   - System sets transaction type to `credit`
   - System updates wallet balance
   - System logs transaction

2. **Debit Transaction**
   - System validates wallet balance
   - System creates transaction record in `wallet_transactions` table
   - System sets transaction type to `debit`
   - System updates wallet balance
   - System logs transaction

3. **Refund Transaction**
   - System creates transaction record in `wallet_transactions` table
   - System sets transaction type to `refund`
   - System updates wallet balance
   - System logs transaction

### Transaction History

1. **Transaction Retrieval**
   - User requests transaction history
   - System retrieves user's transactions from `wallet_transactions` table
   - System filters by date range, type, status
   - System paginates results
   - System displays transaction history

---

## Room System Flow

### Room Creation

1. **Public Room Creation**
   - User creates room
   - System creates room record in `rooms` table
   - System sets room type to `public`
   - System sets room status to `active`
   - System creates room settings in `room_settings` table
   - System creates room statistics in `room_statistics` table
   - System adds user as room owner in `room_members` table

2. **Private Room Creation**
   - User creates room
   - System creates room record in `rooms` table
   - System sets room type to `private`
   - System sets room status to `active`
   - System creates room settings in `room_settings` table
   - System creates room statistics in `room_statistics` table
   - System adds user as room owner in `room_members` table

3. **VIP Room Creation**
   - VIP user creates room
   - System creates room record in `rooms` table
   - System sets room type to `vip`
   - System sets room status to `active`
   - System creates room settings in `room_settings` table
   - System creates room statistics in `room_statistics` table
   - System adds user as room owner in `room_members` table

### Room Joining

1. **Public Room Joining**
   - User browses public rooms
   - User selects room
   - System checks room capacity
   - System checks if user is banned
   - System adds user to room in `room_members` table
   - System sets user role to `member`
   - System updates room statistics

2. **Private Room Joining**
   - User receives room invitation
   - User accepts invitation
   - System adds user to room in `room_members` table
   - System sets user role to `member`
   - System updates room statistics

3. **VIP Room Joining**
   - VIP user browses VIP rooms
   - User selects room
   - System checks user VIP status
   - System checks room capacity
   - System adds user to room in `room_members` table
   - System sets user role to `member`
   - System updates room statistics

### Room Management

1. **Room Role Assignment**
   - Room owner assigns role to member
   - System updates user role in `room_members` table
   - System logs role change

2. **Room Ban**
   - Room admin bans user
   - System creates ban record in `room_bans` table
   - System removes user from room in `room_members` table
   - System logs ban action

3. **Room Mute**
   - Room admin mutes user
   - System creates mute record in `room_mutes` table
   - System logs mute action

### Room Statistics

1. **Statistics Tracking**
   - System tracks room member count
   - System tracks room message count
   - System tracks room activity
   - System updates room statistics in `room_statistics` table

---

## Gift System Flow

### Gift Sending

1. **Gift Selection**
   - User browses available gifts from `gifts` table
   - User selects gift
   - System displays gift details and pricing

2. **Gift Sending**
   - User selects recipient
   - System validates user balance
   - System creates gift send record in `gift_sends` table
   - System creates gift receive record in `gift_receives` table
   - System creates transaction record in `wallet_transactions` table
   - System updates sender wallet balance
   - System updates recipient gift inventory in `user_gifts` table
   - System sends notification to recipient
   - System updates gift statistics

### Gift Receiving

1. **Gift Notification**
   - System sends notification to recipient
   - Recipient views notification
   - Recipient opens gift

2. **Gift Inventory**
   - System adds gift to recipient's inventory in `user_gifts` table
   - System sets gift quantity
   - System sets gift expiration if applicable

### Gift Statistics

1. **Statistics Tracking**
   - System tracks popular gifts
   - System tracks gift trends
   - System tracks gift revenue
   - System updates gift statistics in `gift_statistics` table

---

## Family System Flow

### Family Creation

1. **Family Creation**
   - User creates family
   - System creates family record in `families` table
   - System creates family settings in `family_settings` table
   - System creates family statistics in `family_statistics` table
   - System adds user as family owner in `family_members` table
   - System sets user role to `owner`

### Family Joining

1. **Family Request**
   - User requests to join family
   - System creates family request in `family_requests` table
   - System sets request status to `pending`
   - System sends notification to family owner

2. **Family Approval**
   - Family owner reviews request
   - Family owner approves request
   - System updates request status to `approved`
   - System adds user to family in `family_members` table
   - System sets user role to `member`
   - System updates family statistics

### Family Management

1. **Family Role Assignment**
   - Family owner assigns role to member
   - System updates user role in `family_members` table
   - System logs role change

2. **Family Removal**
   - Family owner removes member
   - System removes user from family in `family_members` table
   - System updates family statistics

### Family Statistics

1. **Statistics Tracking**
   - System tracks family member count
   - System tracks family activity
   - System tracks family performance
   - System updates family statistics in `family_statistics` table

---

## Agency System Flow

### Agency Creation

1. **Agency Creation**
   - User creates agency
   - System creates agency record in `agencies` table
   - System creates agency statistics in `agency_statistics` table
   - System adds user as agency owner in `agency_members` table
   - System sets user role to `owner`

### Agency Joining

1. **Agency Invitation**
   - Agency owner sends invitation to user
   - User receives invitation
   - User accepts invitation
   - System adds user to agency in `agency_members` table
   - System sets user role to `member`
   - System updates agency statistics

### Agency Management

1. **Agency Role Assignment**
   - Agency owner assigns role to member
   - System updates user role in `agency_members` table
   - System logs role change

2. **Agency Removal**
   - Agency owner removes member
   - System removes user from agency in `agency_members` table
   - System updates agency statistics

### Agency Commission

1. **Commission Calculation**
   - Agency member performs action
   - System calculates commission based on `agency_commissions` table
   - System creates transaction record in `wallet_transactions` table
   - System updates agency member wallet balance

---

## Recharge Agency System Flow

### Recharge Agency Registration

1. **Recharge Agency Creation**
   - Agency owner creates recharge agency
   - System creates recharge agency record in `recharge_agencies` table
   - System creates recharge agency rates in `recharge_agency_rates` table
   - System links to parent agency in `agencies` table

### Recharge Agency Operation

1. **Recharge Processing**
   - User visits recharge agency
   - Agency processes recharge
   - System creates recharge record in `user_recharges` table
   - System creates agency transaction record in `recharge_agency_transactions` table
   - System calculates agency commission based on `recharge_agency_rates` table
   - System creates transaction record in `wallet_transactions` table
   - System updates user wallet balance

### Recharge Agency Statistics

1. **Statistics Tracking**
   - System tracks recharge agency performance
   - System tracks recharge volume
   - System tracks commission earnings
   - System updates agency statistics

---

## VIP System Flow

### VIP Subscription

1. **VIP Tier Selection**
   - User browses VIP tiers from `vip_tiers` table
   - User selects VIP tier
   - System displays tier details and pricing

2. **VIP Purchase**
   - User purchases VIP subscription
   - System creates VIP subscription record in `user_vip_subscriptions` table
   - System creates purchase record in `vip_purchase_history` table
   - System creates transaction record in `wallet_transactions` table
   - System updates user wallet balance
   - System grants VIP benefits

3. **VIP Renewal**
   - System checks subscription expiration
   - System sends renewal notification
   - User renews subscription
   - System updates subscription expiration
   - System creates purchase record in `vip_purchase_history` table
   - System creates transaction record in `wallet_transactions` table

### VIP Benefits

1. **Benefit Granting**
   - System grants VIP benefits based on `vip_benefits` table
   - System applies benefit to user account
   - System logs benefit grant

2. **Benefit Revocation**
   - Subscription expires
   - System revokes VIP benefits
   - System logs benefit revocation

---

## Ranking System Flow

### Ranking Calculation

1. **Score Calculation**
   - System calculates user score based on activity
   - System updates user ranking in `user_rankings` table
   - System creates ranking history record in `ranking_history` table

2. **Ranking Update**
   - System updates rankings periodically
   - System recalculates user positions
   - System updates `user_rankings` table
   - System creates ranking snapshot in `ranking_history` table

### Ranking Display

1. **Leaderboard Display**
   - User requests leaderboard
   - System retrieves rankings from `user_rankings` table
   - System filters by ranking category
   - System paginates results
   - System displays leaderboard

### Ranking History

1. **History Tracking**
   - System tracks ranking changes over time
   - System stores ranking snapshots in `ranking_history` table
   - System calculates ranking trends
   - System displays ranking history

---

## Notification System Flow

### Notification Creation

1. **Notification Generation**
   - System event triggers notification
   - System creates notification record in `notifications` table
   - System sets notification type from `notification_types` table
   - System uses template from `notification_templates` table
   - System sets notification status to `unread`

2. **Notification Delivery**
   - System delivers notification to user
   - System sends push notification if enabled
   - System updates notification delivery status

### Notification Management

1. **Notification Reading**
   - User reads notification
   - System updates notification status to `read`
   - System logs notification read

2. **Notification Archiving**
   - User archives notification
   - System updates notification status to `archived`
   - System logs notification archive

### Notification Settings

1. **Preference Management**
   - User sets notification preferences
   - System updates user preferences in `notification_settings` table
   - System applies preferences to notification delivery

---

## Messaging System Flow

### Message Sending

1. **Room Message**
   - User sends message to room
   - System creates message record in `messages` table
   - System sets message type to `text`
   - System links message to room
   - System delivers message to room members
   - System updates room statistics

2. **Direct Message**
   - User sends direct message
   - System creates conversation record in `conversations` table
   - System adds participants to conversation
   - System creates message record in `messages` table
   - System sets message type to `text`
   - System links message to conversation
   - System delivers message to recipient

3. **Gift Message**
   - User sends gift as message
   - System creates message record in `messages` table
   - System sets message type to `gift`
   - System processes gift sending
   - System delivers message to recipient

### Message Reading

1. **Read Receipt**
   - User reads message
   - System creates read receipt in `message_reads` table
   - System updates message status
   - System notifies sender

### Message Management

1. **Message Deletion**
   - User deletes message
   - System creates deletion record in `message_deletions` table
   - System marks message as deleted
   - System logs deletion

2. **Message Pinning**
   - Room admin pins message
   - System creates pin record in `message_pins` table
   - System displays pinned message

---

## Store System Flow

### Item Purchase

1. **Item Selection**
   - User browses store items from `store_items` table
   - User selects item
   - System displays item details and pricing

2. **Item Purchase**
   - User purchases item
   - System validates user balance
   - System creates purchase record in `user_purchases` table
   - System creates transaction record in `wallet_transactions` table
   - System updates user wallet balance
   - System adds item to user inventory in `user_inventory` table
   - System sends notification to user

### Inventory Management

1. **Inventory Display**
   - User views inventory
   - System retrieves user inventory from `user_inventory` table
   - System displays inventory items

2. **Item Usage**
   - User uses item
   - System updates item quantity in `user_inventory` table
   - System applies item effect
   - System logs item usage

---

## Future Scalability Considerations

### Database Scaling

1. **Read Replicas**
   - Implement read replicas for high read volume
   - Distribute read queries across replicas
   - Use primary for write operations

2. **Partitioning**
   - Partition large tables by date or user ID
   - Implement horizontal partitioning for messages
   - Implement vertical partitioning for user data

3. **Caching Layer**
   - Implement Redis caching for frequently accessed data
   - Cache user profiles, room information, gift data
   - Implement cache invalidation strategies

4. **Connection Pooling**
   - Implement connection pooling for database connections
   - Optimize connection pool size
   - Monitor connection pool performance

### Data Archival

1. **Message Archival**
   - Archive old messages to cold storage
   - Implement message retention policy
   - Provide search functionality for archived messages

2. **Transaction Archival**
   - Archive old transactions to cold storage
   - Implement transaction retention policy
   - Provide audit trail for archived transactions

3. **Log Archival**
   - Archive old logs to cold storage
   - Implement log retention policy
   - Provide search functionality for archived logs

### Performance Optimization

1. **Query Optimization**
   - Implement query optimization strategies
   - Use query hints for complex queries
   - Monitor query performance

2. **Index Optimization**
   - Regularly review and optimize indexes
   - Remove unused indexes
   - Add composite indexes for common query patterns

3. **Materialized Views**
   - Implement materialized views for complex aggregations
   - Refresh materialized views periodically
   - Use materialized views for reporting

### High Availability

1. **Database Replication**
   - Implement multi-region replication
   - Use synchronous replication for critical data
   - Use asynchronous replication for non-critical data

2. **Failover Strategy**
   - Implement automatic failover
   - Regularly test failover procedures
   - Monitor failover performance

3. **Backup Strategy**
   - Implement regular database backups
   - Store backups in multiple locations
   - Regularly test backup restoration

### Security Enhancements

1. **Data Encryption**
   - Implement encryption at rest
   - Implement encryption in transit
   - Use key management service

2. **Audit Logging**
   - Implement comprehensive audit logging
   - Log all data access
   - Regularly review audit logs

3. **Compliance**
   - Ensure compliance with data protection regulations
   - Implement data retention policies
   - Provide data export functionality

### Monitoring and Alerting

1. **Performance Monitoring**
   - Monitor database performance metrics
   - Set up alerts for performance degradation
   - Implement performance dashboards

2. **Capacity Planning**
   - Monitor database growth
   - Predict future capacity needs
   - Plan for scaling

3. **Error Monitoring**
   - Monitor database errors
   - Set up alerts for critical errors
   - Implement error tracking

---

## Conclusion

This database design provides a comprehensive foundation for the Joojo Chat application, supporting millions of users with scalable architecture, proper relationships, security measures, and future scalability considerations. The design follows best practices for database architecture and is ready for implementation with Supabase.
