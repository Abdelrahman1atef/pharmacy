//-------------------------------------------
const tableName = "Cart";
const colProductId = "product_id";
const colProductNameAr = "product_name_ar";
const colProductNameEn = "product_name_en";
const colSelectedUnitType = "selected_unit_type";
const colSelectedUnitPrice = "selected_unit_price";
const colProductImageUrl = "product_image_url";
const colQuantity = "quantity";
const colProductImages = "product_images";

// sql statement
// -----------------------------
String createTable = """
CREATE TABLE $tableName (
    $colProductId INTEGER PRIMARY KEY,                    -- Product ID from API
    $colProductNameAr TEXT NOT NULL,                      -- Product name in Arabic
    $colProductNameEn TEXT NOT NULL,                      -- Product name in English
    $colSelectedUnitType TEXT NOT NULL,                   -- Selected unit type (e.g., "علبة", "شريط")
    $colSelectedUnitPrice REAL NOT NULL,                  -- Price of selected unit type
    $colProductImageUrl TEXT,                             -- Product image URL
    $colQuantity INTEGER NOT NULL,                        -- Quantity in cart
    $colProductImages TEXT                                -- Product images as JSON string
);
""";

String dropTable = "DROP TABLE IF EXISTS $tableName";
