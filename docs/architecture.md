# Architecture

Trigger → Handler → Service for Order, Payment, Visit, Inventory.
PricingEngine / PromotionOptimizer are intentionally non-Flow.
ERP uses Queueable + mock OAuth.
