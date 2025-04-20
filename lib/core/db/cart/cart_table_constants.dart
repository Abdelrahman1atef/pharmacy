//-------------------------------------------
const tableName = "Cart";
const colProductId = "product_id";
const colProductNameAr = "product_name_ar";
const colProductNameEn = "product_name_en";
const colProductUnit1 = "product_unit1";
const colPellPrice = "sell_price";
const colProductUnit2 = "product_unit2";
const colProductUnit1_2 = "product_unit1_2";
const colUnit2SellPrice = "unit2_sell_price";
const colProductImageUrl = "product_image_url";
const colQuantity = "quantity";
const colProductImages="product_images";

// sql statement
// -----------------------------
String createTable = """
CREATE TABLE $tableName (
    $colProductId INTEGER PRIMARY KEY AUTOINCREMENT,   -- Auto-incrementing primary key
    $colProductNameAr TEXT NOT NULL,                   -- Column for text data
    $colProductNameEn TEXT NOT NULL,                   -- Column for text data
    $colProductUnit1 TEXT NOT NULL,                    -- Column for text data
    $colPellPrice INTEGER,                             -- Column for text data
    $colProductUnit2 TEXT NOT NULL,                    -- Column for text data
    $colProductUnit1_2 INTEGER,                        -- Column for text data
    $colUnit2SellPrice INTEGER,                        -- Column for text data
    $colProductImageUrl TEXT,                          -- Column for larger text or binary data
    $colQuantity INTEGER,                               -- Column for color data
    $colProductImages TEXT
);
""";

String dropTable = "DROP TABLE IF EXISTS $tableName";
