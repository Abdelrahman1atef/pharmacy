//-------------------------------------------
const tableName = "Cart";
const productId = "productId";
const productNameAr = "productNameAr";
const productNameEn = "productNameEn";
const productUnit1 = "productUnit1";
const sellPrice = "sellPrice";
const productUnit2 = "productUnit2";
const productUnit1_2 = "productUnit1_2";
const unit2SellPrice = "unit2SellPrice";
const productImageUrl = "productImageUrl";
const quantity = "quantity";

// sql statement
// -----------------------------
String createTable = """
CREATE TABLE $tableName (
    $productId INTEGER PRIMARY KEY AUTOINCREMENT,   -- Auto-incrementing primary key
    $productNameAr TEXT NOT NULL,                   -- Column for text data
    $productNameEn TEXT NOT NULL,                   -- Column for text data
    $productUnit1 TEXT NOT NULL,                    -- Column for text data
    $sellPrice INTEGER,                             -- Column for text data
    $productUnit2 TEXT NOT NULL,                    -- Column for text data
    $productUnit1_2 INTEGER,                        -- Column for text data
    $unit2SellPrice INTEGER,                        -- Column for text data
    $productImageUrl TEXT,                          -- Column for larger text or binary data
    $quantity INTEGER                               -- Column for color data
);
""";

String dropTable = "DROP TABLE IF EXISTS $tableName";
