# ACE Parking Management, Inc.

## Software Developer Assessment

Welcome! As part of your interview with ACE Parking, you have been invited to demonstrate your skills in two areas critical to your success: **SQL Server** and **REST API development**.

---

## Overview

This assessment has two parts:

1. **SQL Server Schema** - Design and create a database schema to store invoice data (customers, products, and orders)
2. **REST API** - Build endpoints to create and retrieve order data

**Time Expectation**: This is a take-home assessment. We expect it to take approximately 4-6 hours. There is no strict time limit.

**Deliverable**: A public GitHub repository containing your SQL scripts and API code.

---

## Prerequisites

Before you begin, ensure you have:

- **SQL Server** - Version 14.0 or greater (see [Setup Guide](docs/SETUP-SQLSERVER.md) for options including Docker and Azure SQL)
- **Development Environment** - Choose ONE:
  - **C#/.NET**: Visual Studio 2022+ with .NET 9+
  - **Node.js**: Node.js 18+ with npm/yarn
- **Postman** (optional but recommended) - [Download here](https://www.postman.com/)
- **Git** - For version control and submission

---

## Part 1: SQL Server Schema

This is your chance to demonstrate your Microsoft SQL Server skills. Think about defaults, datatypes, integrity, constraints, and relationships.

### Requirements

1. Create table DDL to store the data necessary for an invoice system:
   - **Customers** - Company information and contact details
   - **Products** - Items that can be ordered with pricing
   - **Orders** - Invoice header information
   - **Order Details/Line Items** - Individual products within an order

2. Consider:
   - What happens if someone tries to order a product that doesn't exist?
   - How do you ensure data integrity?
   - What are appropriate data types for each field?

3. Create queries or stored procedures for:
   - Add a new order (with line items)
   - Get all orders
   - Get a specific order with full details
   - Get all products
   - Get all customers

4. **Deliverable**: SQL script file(s) in a `/database` folder in your repository

> **Tip**: If using SSMS, you can use "Generate Scripts" to export your schema and data.

### Reference Data

See [`database/seed-data.sql`](database/seed-data.sql) for sample customer and product data to use in your testing. Your schema should accommodate this data structure.

---

## Part 2: REST API Implementation

Build a REST API that connects to your SQL Server database and exposes the following endpoints.

### Required Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/api/public/hello` | Health check - returns a simple message | No |
| GET | `/api/customer/viewall` | List all customers | Yes |
| GET | `/api/product/viewall` | List all products | Yes |
| GET | `/api/order/viewall` | List all orders (summary) | Yes |
| GET | `/api/order/vieworderdetail` | List all orders with line item details | Yes |
| GET | `/api/order/details/{invoiceNumber}` | Get a specific order with full details | Yes |
| POST | `/api/order/new` | Create a new order | Yes |

### Authentication

Use header-based API key authentication:
- Header name: `x-api-key`
- The value can be any non-empty string (you define what's valid)
- Return `401 Unauthorized` if the header is missing or invalid

### Error Handling

Your API should handle errors gracefully:
- `400 Bad Request` - Invalid input data
- `401 Unauthorized` - Missing or invalid API key
- `404 Not Found` - Resource doesn't exist
- `500 Internal Server Error` - Unexpected errors (don't expose internal details)

### Platform Options

Choose ONE platform:

#### Option A: C#/.NET
- Visual Studio 2022 or greater
- .NET 9 or greater
- Use the Web API template

#### Option B: Node.js
- Node.js 18 or greater
- Express, Fastify, or similar framework
- Use the `mssql` package for SQL Server connectivity

### Request/Response Format

**Important**: All JSON property names must use **camelCase** (e.g., `customerId`, `productName`, `invoiceDate`).

> **Note for C#/.NET developers**: .NET defaults to PascalCase JSON serialization. You must configure your serializer to use camelCase. Example:
> ```csharp
> builder.Services.ConfigureHttpJsonOptions(options => {
>     options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
> });
> ```

See the [`examples/`](examples/) folder for JSON samples:
- [`post-order-request.json`](examples/post-order-request.json) - Creating a new order
- [`get-order-response.json`](examples/get-order-response.json) - Order details response
- [`get-customers-response.json`](examples/get-customers-response.json) - Customer list response
- [`get-products-response.json`](examples/get-products-response.json) - Product list response

Your API responses **must match** the field names shown in these examples exactly.

---

## Reference API

A live reference API is available for you to explore the expected behavior:

**Base URL**: `https://candidateinvoice-bcc4a5djcrbthwep.westus3-01.azurewebsites.net`

**API Key**: `DE7405BBC91A42319C6820C48B8DCE51`

Use the included Postman collection ([`Ace-Recruiting-Test-Example.postman_collection.json`](Ace-Recruiting-Test-Example.postman_collection.json)) to explore all endpoints.

### Quick Test

```bash
# Health check (no auth required)
curl https://candidateinvoice-bcc4a5djcrbthwep.westus3-01.azurewebsites.net/api/public/hello

# Get all products (auth required)
curl -H "x-api-key: DE7405BBC91A42319C6820C48B8DCE51" \
  https://candidateinvoice-bcc4a5djcrbthwep.westus3-01.azurewebsites.net/api/product/viewall
```

---

## Submission Instructions

1. **Create a public GitHub repository** with your solution

2. **Repository structure** should include:
   ```
   your-repo/
   ├── database/
   │   ├── schema.sql        # Your table definitions
   │   ├── seed-data.sql     # Sample data (can use ours or your own)
   │   └── stored-procs.sql  # Stored procedures (if used)
   ├── src/                  # Your API source code
   ├── README.md             # Setup and run instructions
   └── ...
   ```

3. **Your README should include**:
   - How to set up the database
   - How to configure the connection string
   - How to run the API locally
   - Any assumptions or design decisions you made

4. **Email the repository URL** to your ACE Parking contact

---

## Evaluation Criteria

We will evaluate your submission on:

| Criteria | What We're Looking For |
|----------|----------------------|
| **SQL Design** | Proper normalization, appropriate data types, constraints, foreign keys, indexes where appropriate |
| **API Functionality** | All endpoints work correctly and return proper response formats |
| **JSON Format** | Responses use camelCase property names matching the examples exactly |
| **Code Quality** | Clean, readable code that follows conventions for your chosen platform |
| **Error Handling** | Graceful handling of invalid inputs, missing data, and edge cases |
| **Documentation** | Clear setup instructions and any design decisions explained |

---

## Questions?

If you have questions about the requirements, please reach out to your ACE Parking contact. We're happy to clarify anything that's unclear.

Good luck!
