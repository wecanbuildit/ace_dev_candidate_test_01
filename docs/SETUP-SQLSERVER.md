# SQL Server Setup Guide

This guide covers how to set up a local SQL Server instance for the ACE Parking developer assessment. Choose the option that best fits your development environment.

---

## Option 1: Windows with SQL Server Management Studio (SSMS)

This is the recommended approach if you're on Windows and familiar with Microsoft tools.

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

## Option 2: macOS/Linux with Docker

This approach works on any platform and provides an isolated SQL Server instance.

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### Run SQL Server in Docker
```bash
# Pull the SQL Server 2022 image
docker pull mcr.microsoft.com/mssql/server:2022-latest

# Run the container
docker run -e "ACCEPT_EULA=Y" \
           -e "MSSQL_SA_PASSWORD=YourStrong@Passw0rd" \
           -p 1433:1433 \
           --name sql_server \
           --hostname sql_server \
           -d mcr.microsoft.com/mssql/server:2022-latest
```

> **Important**: The password must meet SQL Server complexity requirements:
> - At least 8 characters
> - Uppercase, lowercase, numbers, and special characters

### Connect to the Database

#### Using Azure Data Studio (Recommended for macOS/Linux)
1. Download [Azure Data Studio](https://azure.microsoft.com/en-us/products/data-studio/) (free, cross-platform)
2. Click "New Connection"
3. Enter:
   - Server: `localhost,1433`
   - Authentication: SQL Login
   - User: `sa`
   - Password: `YourStrong@Passw0rd`

#### Using Command Line
```bash
# Install sqlcmd (if not already installed)
# macOS: brew install mssql-tools
# Linux: See Microsoft docs for your distro

# Connect
sqlcmd -S localhost,1433 -U sa -P 'YourStrong@Passw0rd'
```

### Create Your Database
```sql
CREATE DATABASE AceInvoice;
GO
USE AceInvoice;
GO
-- Now create your tables...
```

### Stop/Start the Container
```bash
# Stop
docker stop sql_server

# Start again later
docker start sql_server

# Remove completely
docker rm -f sql_server
```

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
// Local SQL Server
"Server=localhost;Database=AceInvoice;Trusted_Connection=True;TrustServerCertificate=True;"

// Docker SQL Server
"Server=localhost,1433;Database=AceInvoice;User Id=sa;Password=YourStrong@Passw0rd;TrustServerCertificate=True;"

// Azure SQL
"Server=tcp:yourserver.database.windows.net,1433;Database=AceInvoice;User ID=yourusername;Password=yourpassword;Encrypt=True;TrustServerCertificate=False;"
```

### For Node.js Applications (using mssql package)
```javascript
// Local/Docker SQL Server
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
- Check password meets complexity requirements
- Try `docker logs sql_server` to see error messages

### Can't connect to localhost
- Verify SQL Server is running
- Check firewall allows port 1433
- For Docker, ensure the container is running: `docker ps`

### Azure: Connection refused
- Add your IP to the firewall rules
- Verify the server name is correct (include `.database.windows.net`)
- Ensure encryption settings match

---

## Next Steps

Once connected:
1. Create your database schema (Customers, Products, Orders, OrderDetails tables)
2. Run the `seed-data.sql` script to populate test data
3. Test your queries before building the API
