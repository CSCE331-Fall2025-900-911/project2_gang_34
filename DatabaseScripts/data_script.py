# seed/gen_past_items.py
import pandas as pd
import numpy as np
from pathlib import Path

N = 100  # number of rows

rng = np.random.default_rng()  # will produce random csv file every time you run

df = pd.DataFrame({
    "name": [f"Past Item {i+1}" for i in range(N)],
    "category": rng.choice(["burger", "fries", "sandwich", "drink"], N),
    "price_cents": rng.integers(100, 1000, N),
    "sold_at": pd.to_datetime("now") - pd.to_timedelta(rng.integers(0, 60*60*24*180, N), unit="s"),
    "qty": rng.integers(1, 5, N),
    "notes": rng.choice(["", "promo"], N, p=[0.8, 0.2])
})


out_path = Path("seed/csv/past_items.csv") # will create csv file in seed/csv folder on its own
out_path.parent.mkdir(parents=True, exist_ok=True)

df.to_csv(out_path, index=False)
print(f"CSV written to {out_path}")
