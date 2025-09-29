# seed/gen_past_items.py
import pandas as pd
import numpy as np

N = 100  # number of rows

rng = np.random.default_rng(seed=42)

df = pd.DataFrame({
    "name": [f"Past Item {i+1}" for i in range(N)],
    "category": rng.choice(["food", "drink", "dessert", "snack"], N),
    "price_cents": rng.integers(150, 1900, N),
    "sold_at": pd.to_datetime("now") - pd.to_timedelta(rng.integers(0, 60*60*24*180, N), unit="s"),
    "qty": rng.integers(1, 5, N),
    "notes": rng.choice(["", "promo"], N, p=[0.8, 0.2])
})

df.to_csv("seed/csv/past_items.csv", index=False)
print("CSV written.")
