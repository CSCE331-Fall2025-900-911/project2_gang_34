# seed/gen_past_items.py
import pandas as pd
import numpy as np
from pathlib import Path

N = 100  # number of rows

rng = np.random.default_rng(seed=30)  # gave seed for same script output every run

now = pd.Timestamp.utcnow().tz_localize(None)
start = now - pd.Timedelta(weeks=39)

window_seconds = 39 * 7 * 24 * 60 * 60
random_secs = rng.integers(0, window_seconds, size=N)

# build random dates in the range
dates = start + pd.to_timedelta(random_secs, unit="s")

# round down to the nearest hour (removes minutes/seconds)
dates = pd.Series(dates).dt.floor("h")

# sort to make them incremental over time
dates = pd.Series(dates).sort_values(ignore_index=True)

# Past restocks data
df = pd.DataFrame({
    "id": [f"{i+1}" for i in range(N)],
    "item_id": rng.integers(1, 17, size=N),                    # 1–16 inclusive
    "modification_id": [f"{i+1}" for i in range(N)],           # sequential IDs
    "is_modification": rng.choice([True, False], size=N),      # boolean flag
    "cost": rng.integers(1, 11, size=N) + 0.99,                # 1.99–10.99
    "quantity": rng.integers(1, 6, size=N),                    # 1–5 quantity
    "purchase_date": dates,                                    # random incremental dates
    "custom_item": ["n/a"] * N,                                # placeholder
    "custom_modification": ["n/a"] * N,                        # placeholder
    "custom_note": ["n/a"] * N,    
})


out_path = Path("seed/csv/past_restocks.csv") # will create csv file in seed/csv folder on its own
out_path.parent.mkdir(parents=True, exist_ok=True)

df.to_csv(out_path, index=False)
print(f"CSV written to {out_path}")
