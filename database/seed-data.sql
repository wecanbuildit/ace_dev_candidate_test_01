-- =============================================
-- ACE Parking - Developer Assessment
-- Seed Data Script
-- =============================================
-- This script provides sample data for testing your API.
-- Run this AFTER creating your schema tables.
-- =============================================

-- =============================================
-- CUSTOMERS
-- =============================================
-- Note: Use these customer IDs when testing your POST /api/order/new endpoint

INSERT INTO Customers (
    CustomerId,
    CustomerName,
    CustomerAddress1,
    CustomerAddress2,
    CustomerCity,
    CustomerState,
    CustomerPostalCode,
    CustomerTelephone,
    CustomerContactName,
    CustomerEmailAddress
) VALUES
(
    'AA5FD07A-05D6-460F-B8E3-6A09142F9D71',
    'Smith, LLC',
    '505 Central Avenue',
    'Suite 100',
    'San Diego',
    'CA',
    '90383',
    '619-483-0987',
    'Jane Smith',
    'email@jane.com'
),
(
    '15907644-3F44-448B-B64E-A949C529FA0B',
    'Doe, Inc',
    '123 Main Street',
    NULL,
    'Los Angeles',
    'CA',
    '90010',
    '310-555-1212',
    'John Doe',
    'email@doe.com'
);

-- =============================================
-- PRODUCTS
-- =============================================
-- Note: Use these product IDs when testing your POST /api/order/new endpoint

INSERT INTO Products (
    ProductId,
    ProductName,
    ProductCost
) VALUES
(
    '26812D43-CEE0-4413-9A1B-0B2EABF7E92C',
    'Thingie',
    2.00
),
(
    '3C85F645-CE57-43A8-B192-7F46F8BBC273',
    'Gadget',
    5.15
),
(
    'A102E2B7-30D6-4AB6-B92B-8570A7E1659C',
    'Gizmo',
    1.00
),
(
    '9E3EF8CE-A6FD-4C9B-AC5D-C3CB471E1E27',
    'Widget',
    2.50
);

-- =============================================
-- VERIFICATION QUERIES
-- =============================================
-- Run these to verify your data was inserted correctly:

-- SELECT * FROM Customers;
-- SELECT * FROM Products;
