# seed/gen_past_modifications.py
import pandas as pd
import numpy as np
from pathlib import Path

N = 100

rng = np.random.default_rng(seed=42)  # set the seed for reproducibility

id = [f"{i+1}" for i in range(N)]
customer_id = [f"{rng.integers(1, 51)}" for _ in range(N)] # 50 diff customers
order_id = [f"{rng.integers(1, 201)}" for _ in range(N)] # 200 diff orders
past_item_id = rng.integers(1, 101, size=N) # 100 past items
modification_id = rng.integers(1, 21, size=N) # 20 possible mods
custom_cost = rng.choice([None] * 8 + [round(rng.uniform(0.50, 3.00), 2) for _ in range(2*N)], size=N) 

df = pd.DataFrame({
    "id": [f"{i+1}" for i in range(N)],
    "customer_id": customer_id,
    "order_id": order_id,
    "past_item_id": past_item_id,
    "modification_id": 	modification_id,
    "custom_cost": custom_cost,
})

df["custom_cost"] = df["custom_cost"].fillna("")

out_path = Path("GeneratedData/past_modifications.csv")
out_path.parent.mkdir(parents=True, exist_ok=True)

df.to_csv(out_path, index=False)
