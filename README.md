# sf-enterprise-order-beat-management

Legacy pro-code Salesforce for **beat → visit → order → fulfillment**. No Flow metadata.

Field reps follow weekday beats, capture orders, apply pricing/promotions, request approval, submit to a mock ERP, then collect payment.

Ground truth: `migration/ground-truth/`.

```bash
sf org create scratch -f config/project-scratch-def.json -a order-beat
sf project deploy start -o order-beat
python3 scripts/seed-data/generate_seed.py
```
