# SQL Server Setup Guide

This guide covers how to set up a local SQL Server instance for the ACE Parking developer assessment. Choose the option that best fits your development environment.

---

## Recommended Setup by Platform

| Platform | Recommended Option |
|----------|-------------------|
| **macOS** | [Option 1: Docker](#option-1-docker-recommended-for-macoslinux) |
| **Linux** | [Option 1: Docker](#option-1-docker-recommended-for-macoslinux) |
| **Windows** | [Option 2: SQL Server + SSMS](#option-2-windows-with-sql-server-management-studio-ssms) |
| **Any (Cloud)** | [Option 3: Azure SQL](#option-3-azure-sql-database-cloud) |

---

## Option 1: Docker (Recommended for macOS/Linux)

This is the **fastest and easiest** way to get started on macOS or Linux. We provide a ready-to-use Docker Compose configuration.

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### Quick Start

1. **Navigate to the docker folder:**
   ```bash
   cd docker
   ```

2. **Create your init.sql file** with your schema and seed data (see `database/seed-data.sql` for reference)

3. **Start SQL Server:**
   ```bash
   docker compose up -d
   ```

   This will:
   - Start SQL Server 2022
   - Wait for it to be healthy
   - Automatically run your `init.sql` script

4. **Verify it's running:**
   ```bash
   docker compose ps
   docker compose logs db-init
   ```

See [`docker/README.md`](../docker/README.md) for full details on configuration and adding your API.

### Connection Details

| Setting | Value |
|---------|-------|
| Server | `localhost,1433` |
| Username | `sa` |
| Password | `YourStrong@Passw0rd` |
| Database | `AceInvoice` |

### Connect with Azure Data Studio (Recommended)
1. Download [Azure Data Studio](https://azure.microsoft.com/en-us/products/data-studio/) (free, cross-platform)
2. Click "New Connection"
3. Enter the connection details above

### Cleanup
```bash
# Stop containers
docker compose down

# Stop and remove all data
docker compose down -v
```

---

## Option 2: Windows with SQL Server Management Studio (SSMS)

This is the traditional approach for Windows developers familiar with Microsoft tools.

### Install SQL Server
1. Download [SQL Server 2022 Developer Edition](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (free)
2. Run the installer and choose "Basic" installation
3. Note the connection string provided at the end

### Install SSMS
1. Download [SQL Server Management Studio](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
2. Install and launch SSMS
3. Connect to your local instance (usually `localhost` or `.\SQLEXPRESS`)

### Create Your Database
1. Right-click "Databases" > "New Database"
2. Name it `AceInvoice` (or your preferred name)
3. Create your tables and run the seed data script

### Export Your Schema (for submission)
1. Right-click your database > "Tasks" > "Generate Scripts"
2. Select "Script entire database and all database objects"
3. Choose "Save to file" with a single file
4. Include both schema and data if desired

---

## Option 3: Azure SQL Database (Cloud)

If you prefer a cloud-based solution or can't run Docker locally.

### Create a Free Azure Account
1. Go to [Azure Free Account](https://azure.microsoft.com/en-us/free/)
2. Sign up (requires credit card but won't charge for free tier)

### Create an Azure SQL Database
1. In Azure Portal, search for "SQL databases"
2. Click "Create"
3. Choose:
   - **Resource group**: Create new or use existing
   - **Database name**: `AceInvoice`
   - **Server**: Create new (note the admin username/password)
   - **Compute + storage**: Click "Configure database" > Choose "Basic" tier (~$5/month or use free credits)

### Configure Firewall
1. After creation, go to your SQL Server resource
2. Click "Networking" in the left menu
3. Add your client IP address
4. Enable "Allow Azure services and resources to access this server"

### Connect
Use the connection string from Azure Portal:
```
Server=tcp:yourserver.database.windows.net,1433;Initial Catalog=AceInvoice;Persist Security Info=False;User ID=yourusername;Password=yourpassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

---

## Connection String Examples

### For .NET Applications
```csharp
// Local SQL Server (Windows)
"Server=localhost;Database=AceInvoice;Trusted_Connection=True;TrustServerCertificate=True;"

// Docker SQL Server
"Server=localhost,1433;Database=AceInvoice;User Id=sa;Password=YourStrong@Passw0rd;TrustServerCertificate=True;"

// Azure SQL
"Server=tcp:yourserver.database.windows.net,1433;Database=AceInvoice;User ID=yourusername;Password=yourpassword;Encrypt=True;TrustServerCertificate=False;"
```

### For Node.js Applications (using mssql package)
```javascript
// Docker SQL Server
const config = {
    server: 'localhost',
    port: 1433,
    database: 'AceInvoice',
    user: 'sa',
    password: 'YourStrong@Passw0rd',
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};

// Azure SQL
const config = {
    server: 'yourserver.database.windows.net',
    database: 'AceInvoice',
    user: 'yourusername',
    password: 'yourpassword',
    options: {
        encrypt: true
    }
};
```

---

## Troubleshooting

### Docker: Container won't start
- Ensure Docker Desktop is running
- Check password meets complexity requirements (8+ chars, uppercase, lowercase, number, special char)
- Run `docker logs <container-name>` to see error messages

### Can't connect to localhost
- Verify SQL Server is running
- Check firewall allows port 1433
- For Docker: ensure container is running with `docker ps`
- Wait 30-60 seconds after starting for SQL Server to initialize

### Azure: Connection refused
- Add your IP to the firewall rules
- Verify the server name is correct (include `.database.windows.net`)
- Ensure encryption settings match

---

## Next Steps

Once connected:
1. Create your database schema (Customers, Products, Orders, OrderDetails tables)
2. Run the `database/seed-data.sql` script to populate test data
3. Test your queries before building the API
