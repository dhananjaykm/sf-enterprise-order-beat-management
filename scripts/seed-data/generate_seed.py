#!/usr/bin/env python3
import csv
from pathlib import Path
out = Path(__file__).parent / "generated"
out.mkdir(exist_ok=True)
def w(name, headers, rows):
    with (out / name).open("w", newline="") as f:
        wr = csv.DictWriter(f, fieldnames=headers); wr.writeheader(); wr.writerows(rows)
w("Outlet__c.csv", ["Name", "Segment__c", "Channel__c"],
  [{"Name": f"Outlet {i:04d}", "Segment__c": ["GOLD","SILVER","BRONZE"][i%3], "Channel__c": "Kirana"} for i in range(1, 2001)])
w("Beat__c.csv", ["Day_of_Week__c", "Status__c", "Region__c"],
  [{"Day_of_Week__c": ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][i%6], "Status__c": "Active", "Region__c": f"R{i%10}"} for i in range(1, 201)])
print("Wrote 2000 outlets, 200 beats (plus generate 10k orders in CRM via Bulk API in deploy docs)")
