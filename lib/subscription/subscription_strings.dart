// This is subscription related strings file

final String subscription_info =
    '''• Your payment will be charged to your iTunes Account as soon as you confirm your purchase.\n
• You can manage your subscriptions and turn off auto-renewal from your Account Settings after the purchase.\n
• Your subscription will renew automatically, unless you turn off auto-renew at least 24 hours before the end of the current period.\n
• The cost of renewal will be charged to your account in the 24 hours prior to the end of the current period.\n
• When cancelling a subscription, your subscription will stay active until the end of the period. Auto-renewal will be disabled, but the current subscription will not be refunded.\n
• Any unused portion of a free trial period, if offered, will be forfeited when purchasing a subscription.\n''';


final String have_to_purchase = 'You have to purchase for using premium template';
final String already_subscribed = 'You already purchased subscriptions';
final String store_not_available = 'Store not available';
final String term_of_use = 'Term of Use';
final String manage_purchase = 'Manage Purchase';
final String restore_purchase = 'Restore Purchase';
final String choose_a_plan = 'Choose A Plan';
final String go_premium = 'Go Premium';
final String no_ads = 'No ads';
final String BUY = 'BUY';
final String unlimited_template = 'Unlock unlimited templates';
final String cancel_anytime = 'Cancel anytime';



final String annually_title = '\$29.99 / Annually';
final String annually_description = '12 months at \$2.5 / month';


final String quarterly_title = '\$12.99 / Quarterly';
final String quarterly_description = '3 months at \$4.33 / month';


final String monthly_title = '\$5.99 / Monthly';
// final String monthly_description = '\$5.99 / month';
final String monthly_description = '';


final String weekly_title = '\$2.99 / Weekly';
// final String weekly_description = '\$2.99 / Weekly';
final String weekly_description = '';

//=========================================================================

final String productID_Y_ios = 'yearly_subcription_invoice_generator';
final String productID_Y = 'invoice_generator_yearly_subcription';

final String productID_Q_ios = 'quarterly_subcription_invoice_generator';
final String productID_Q = 'invoice_generator_quarterly_subcription';

final String productID_M_ios = 'monthly_subcription_invoice_generator';
final String productID_M = 'invoice_generator_monthly_subcription';

final String productID_W_ios = 'weekly_subcription_invoice_generator';
final String productID_W = 'invoice_generator_weekly_subcription';

Set<String> productids_ios = Set<String>.from(
    [productID_W_ios, productID_M_ios, productID_Q_ios, productID_Y_ios]);
Set<String> productids_android =
    Set<String>.from([productID_W, productID_M, productID_Q, productID_Y]);
