"""
## 1. Caching
- Caching store data in memory.
- we use caching/persistence to avoid recomputation.
- default storage is MEMORY_ONLY.


## 2. Persistence
- Persistence is more flexible than caching.
- default storage is MEMORY_AND_DISK.
- It allows storing data in:
    - Memory
    - Disk
    - Both

    
### 2.1 Storage Levels

| Storage Level   | Meaning                       |
| --------------- | ----------------------------- |
| MEMORY_ONLY     | Store only in RAM             |
| MEMORY_AND_DISK | If RAM full → spill to disk   |
| DISK_ONLY       | Store only on disk            |
| MEMORY_ONLY_SER | Serialized (uses less memory) |


## 3. Cache vs Persist (Important Difference)

| Feature       | Cache       | Persist      |
| ------------- | ----------- | ------------ |
| Default level | MEMORY_ONLY | User-defined |
| Flexibility   | Less        | More         |
| Syntax        | Simple      | More control |


## 4. When to use caching/persistence
- Use it when:
    - Same DataFrame used multiple times
    - Expensive transformations (joins, aggregations)
    - Iterative algorithms (ML)
- Avoid when:
    - Data used only once
    - Very large data (may cause memory issues)


**NOTE**: Unpersist (Important) To free memory:

```python
df.unpersist()
```


## 5. Key Interview Points
- Spark is lazy → recomputes DAG each action
- Cache avoids recomputation
- Persist gives storage flexibility
- Always unpersist after use
- Over-caching can degrade performance
"""


# -------------------------------------------------------------------------------------------------
# Code Start from here...
# -------------------------------------------------------------------------------------------------




from pyspark.sql import SparkSession
from pyspark.sql.functions import col, count, sum
from pyspark import StorageLevel

# creating the spark object from SS
spark = SparkSession.Builder().master("local[*]").appName("cachingVsPersistence").getOrCreate()

# creating df from csv file
df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("airbnb.csv")

# if the df us multiple times in code then we can use cache and persist
## 1. Caching
df.cache()

# used the df in below 2 operations (count and group by)
print(f"count of df = {df.count()}")

df.groupBy(col("ocean_proximity")).count().show()


## 2. Persistence => default storage is MEMORY_AND_DISK. for more check above table.
df_per = df.filter(col("ocean_proximity")=="<1H OCEAN")
df_per.persist(StorageLevel.MEMORY_AND_DISK)
df_per.select(count(col("total_rooms"))).show()
df_per.groupBy(col("housing_median_age")).agg(sum(col("total_rooms"))).show()
df_per.unpersist() # NOTE: its imp to free the memory.