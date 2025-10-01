-- SQL script to add Status column to Users table
-- This should be executed on your database

-- Note: The Status column already exists in Users table as NCHAR(10)
-- But let's check if we need to modify it
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Users') AND name = 'Status' AND system_type_id = TYPE_ID('nchar') AND max_length = 10)
BEGIN
    -- Update any NULL values to 'active'
    UPDATE dbo.Users
    SET Status = 'active'
    WHERE Status IS NULL;
    
    PRINT 'Status column values updated in Users table';
END
ELSE IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Users') AND name = 'Status')
BEGIN
    -- Add the Status column with default value 'active'
    ALTER TABLE dbo.Users
    ADD Status NCHAR(10) DEFAULT 'active';
    
    PRINT 'Status column added to Users table with default value ''active''';
END
ELSE
BEGIN
    PRINT 'Status column already exists in Users table';
END

-- Create indexes for performance improvement on common search/filter operations
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Status' AND object_id = OBJECT_ID('dbo.Users'))
BEGIN
    CREATE INDEX IX_Users_Status ON dbo.Users(Status);
    PRINT 'Index created on Status column';
END
ELSE
BEGIN
    PRINT 'Index on Status column already exists';
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_FullName' AND object_id = OBJECT_ID('dbo.Users'))
BEGIN
    CREATE INDEX IX_Users_FullName ON dbo.Users(FullName);
    PRINT 'Index created on FullName column';
END
ELSE
BEGIN
    PRINT 'Index on FullName column already exists';
END

-- Make sure we have roles in the system for filtering
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.Roles') AND type = 'U')
BEGIN
    -- Create Roles table if it doesn't exist
    CREATE TABLE dbo.Roles (
        RoleCode NVARCHAR(20) PRIMARY KEY,
        RoleName NVARCHAR(100) NOT NULL
    );
    
    -- Insert basic roles
    INSERT INTO dbo.Roles (RoleCode, RoleName)
    VALUES 
        ('CUSTOMER', 'Customer'),
        ('SHOP_OWNER', 'Shop Owner'),
        ('ADMIN', 'Admin');
        
    PRINT 'Roles table created with basic roles';
END

-- Check if UserRoles linking table exists
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.UserRoles') AND type = 'U')
BEGIN
    -- Create UserRoles table
    CREATE TABLE dbo.UserRoles (
        UserID BIGINT NOT NULL,
        RoleCode NVARCHAR(20) NOT NULL,
        CONSTRAINT PK_UserRoles PRIMARY KEY CLUSTERED (UserID, RoleCode),
        CONSTRAINT FK_UserRoles_Users FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID),
        CONSTRAINT FK_UserRoles_Roles FOREIGN KEY (RoleCode) REFERENCES dbo.Roles(RoleCode)
    );
    
    -- Create index on UserID for faster lookups
    CREATE INDEX IX_UserRoles_UserID ON dbo.UserRoles(UserID);
    
    PRINT 'UserRoles table created with necessary indexes';
END

-- Initial role assignment (optional - uncomment if needed)
-- This assigns the Customer role to all existing users that don't have roles yet
/*
INSERT INTO dbo.UserRoles (UserID, RoleCode)
SELECT u.UserID, r.RoleCode
FROM dbo.Users u
CROSS JOIN dbo.Roles r
WHERE r.RoleCode = 'CUSTOMER'
AND NOT EXISTS (
    SELECT 1 FROM dbo.UserRoles ur 
    WHERE ur.UserID = u.UserID
);
*/
