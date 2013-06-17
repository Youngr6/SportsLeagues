
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/16/2013 11:47:54
-- Generated from EDMX file: C:\dev\src\SportsLeagues\SportsLeagues.Services\SportsLeaguesModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [SportsLeagues];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_PlayerContactDetail]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContactDetails] DROP CONSTRAINT [FK_PlayerContactDetail];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueSeason]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Seasons] DROP CONSTRAINT [FK_LeagueSeason];
GO
IF OBJECT_ID(N'[dbo].[FK_SeasonBox]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Boxes] DROP CONSTRAINT [FK_SeasonBox];
GO
IF OBJECT_ID(N'[dbo].[FK_BoxFixture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Fixtures] DROP CONSTRAINT [FK_BoxFixture];
GO
IF OBJECT_ID(N'[dbo].[FK_HomePlayers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Players] DROP CONSTRAINT [FK_HomePlayers];
GO
IF OBJECT_ID(N'[dbo].[FK_AwayPlayers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Players] DROP CONSTRAINT [FK_AwayPlayers];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueLeagueConfig]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Leagues] DROP CONSTRAINT [FK_LeagueLeagueConfig];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueConfigSeason]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Seasons] DROP CONSTRAINT [FK_LeagueConfigSeason];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Players]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Players];
GO
IF OBJECT_ID(N'[dbo].[ContactDetails]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ContactDetails];
GO
IF OBJECT_ID(N'[dbo].[Leagues]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Leagues];
GO
IF OBJECT_ID(N'[dbo].[Seasons]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Seasons];
GO
IF OBJECT_ID(N'[dbo].[LeagueConfigs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LeagueConfigs];
GO
IF OBJECT_ID(N'[dbo].[Boxes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Boxes];
GO
IF OBJECT_ID(N'[dbo].[Fixtures]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Fixtures];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Players'
CREATE TABLE [dbo].[Players] (
    [Id] uniqueidentifier  NOT NULL,
    [FirstName] nvarchar(50)  NULL,
    [LastName] nvarchar(50)  NULL,
    [Username] nvarchar(50)  NULL,
    [Fixture_Id] uniqueidentifier  NOT NULL,
    [Fixture_1_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'ContactDetails'
CREATE TABLE [dbo].[ContactDetails] (
    [Id] uniqueidentifier  NOT NULL,
    [ContactType] int  NOT NULL,
    [ContactValue] nvarchar(150)  NOT NULL,
    [Description] nvarchar(150)  NOT NULL,
    [Player_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'Leagues'
CREATE TABLE [dbo].[Leagues] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(150)  NOT NULL,
    [LeagueConfig_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'Seasons'
CREATE TABLE [dbo].[Seasons] (
    [Id] uniqueidentifier  NOT NULL,
    [StartDate] datetime  NOT NULL,
    [EndDate] datetime  NOT NULL,
    [Description] nvarchar(150)  NOT NULL,
    [GeneratedDate] datetime  NOT NULL,
    [League_Id] uniqueidentifier  NOT NULL,
    [LeagueConfig_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'LeagueConfigs'
CREATE TABLE [dbo].[LeagueConfigs] (
    [Id] uniqueidentifier  NOT NULL,
    [Iterations] int  NOT NULL,
    [BoxSize] int  NOT NULL,
    [MovementSize] int  NOT NULL
);
GO

-- Creating table 'Boxes'
CREATE TABLE [dbo].[Boxes] (
    [Id] uniqueidentifier  NOT NULL,
    [Season_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'Fixtures'
CREATE TABLE [dbo].[Fixtures] (
    [Id] uniqueidentifier  NOT NULL,
    [Date] datetime  NOT NULL,
    [HomeScore] int  NULL,
    [AwayScore] int  NULL,
    [Winner] int  NULL,
    [Sequence] int  NOT NULL,
    [Box_Id] uniqueidentifier  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Players'
ALTER TABLE [dbo].[Players]
ADD CONSTRAINT [PK_Players]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ContactDetails'
ALTER TABLE [dbo].[ContactDetails]
ADD CONSTRAINT [PK_ContactDetails]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Leagues'
ALTER TABLE [dbo].[Leagues]
ADD CONSTRAINT [PK_Leagues]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Seasons'
ALTER TABLE [dbo].[Seasons]
ADD CONSTRAINT [PK_Seasons]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LeagueConfigs'
ALTER TABLE [dbo].[LeagueConfigs]
ADD CONSTRAINT [PK_LeagueConfigs]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Boxes'
ALTER TABLE [dbo].[Boxes]
ADD CONSTRAINT [PK_Boxes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Fixtures'
ALTER TABLE [dbo].[Fixtures]
ADD CONSTRAINT [PK_Fixtures]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Player_Id] in table 'ContactDetails'
ALTER TABLE [dbo].[ContactDetails]
ADD CONSTRAINT [FK_PlayerContactDetail]
    FOREIGN KEY ([Player_Id])
    REFERENCES [dbo].[Players]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PlayerContactDetail'
CREATE INDEX [IX_FK_PlayerContactDetail]
ON [dbo].[ContactDetails]
    ([Player_Id]);
GO

-- Creating foreign key on [League_Id] in table 'Seasons'
ALTER TABLE [dbo].[Seasons]
ADD CONSTRAINT [FK_LeagueSeason]
    FOREIGN KEY ([League_Id])
    REFERENCES [dbo].[Leagues]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_LeagueSeason'
CREATE INDEX [IX_FK_LeagueSeason]
ON [dbo].[Seasons]
    ([League_Id]);
GO

-- Creating foreign key on [Season_Id] in table 'Boxes'
ALTER TABLE [dbo].[Boxes]
ADD CONSTRAINT [FK_SeasonBox]
    FOREIGN KEY ([Season_Id])
    REFERENCES [dbo].[Seasons]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SeasonBox'
CREATE INDEX [IX_FK_SeasonBox]
ON [dbo].[Boxes]
    ([Season_Id]);
GO

-- Creating foreign key on [Box_Id] in table 'Fixtures'
ALTER TABLE [dbo].[Fixtures]
ADD CONSTRAINT [FK_BoxFixture]
    FOREIGN KEY ([Box_Id])
    REFERENCES [dbo].[Boxes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BoxFixture'
CREATE INDEX [IX_FK_BoxFixture]
ON [dbo].[Fixtures]
    ([Box_Id]);
GO

-- Creating foreign key on [Fixture_Id] in table 'Players'
ALTER TABLE [dbo].[Players]
ADD CONSTRAINT [FK_HomePlayers]
    FOREIGN KEY ([Fixture_Id])
    REFERENCES [dbo].[Fixtures]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_HomePlayers'
CREATE INDEX [IX_FK_HomePlayers]
ON [dbo].[Players]
    ([Fixture_Id]);
GO

-- Creating foreign key on [Fixture_1_Id] in table 'Players'
ALTER TABLE [dbo].[Players]
ADD CONSTRAINT [FK_AwayPlayers]
    FOREIGN KEY ([Fixture_1_Id])
    REFERENCES [dbo].[Fixtures]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AwayPlayers'
CREATE INDEX [IX_FK_AwayPlayers]
ON [dbo].[Players]
    ([Fixture_1_Id]);
GO

-- Creating foreign key on [LeagueConfig_Id] in table 'Leagues'
ALTER TABLE [dbo].[Leagues]
ADD CONSTRAINT [FK_LeagueLeagueConfig]
    FOREIGN KEY ([LeagueConfig_Id])
    REFERENCES [dbo].[LeagueConfigs]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_LeagueLeagueConfig'
CREATE INDEX [IX_FK_LeagueLeagueConfig]
ON [dbo].[Leagues]
    ([LeagueConfig_Id]);
GO

-- Creating foreign key on [LeagueConfig_Id] in table 'Seasons'
ALTER TABLE [dbo].[Seasons]
ADD CONSTRAINT [FK_LeagueConfigSeason]
    FOREIGN KEY ([LeagueConfig_Id])
    REFERENCES [dbo].[LeagueConfigs]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_LeagueConfigSeason'
CREATE INDEX [IX_FK_LeagueConfigSeason]
ON [dbo].[Seasons]
    ([LeagueConfig_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------