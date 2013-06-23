
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/19/2013 12:31:37
-- Generated from EDMX file: C:\dev\src\SportsLeagues\SportsLeagues.Services\LeaguesModel.edmx
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

IF OBJECT_ID(N'[dbo].[FK_BoxFixture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Fixtures] DROP CONSTRAINT [FK_BoxFixture];
GO
IF OBJECT_ID(N'[dbo].[FK_SeasonBox]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Boxes] DROP CONSTRAINT [FK_SeasonBox];
GO
IF OBJECT_ID(N'[dbo].[FK_PlayerContactDetail]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContactDetails] DROP CONSTRAINT [FK_PlayerContactDetail];
GO
IF OBJECT_ID(N'[dbo].[FK_FK_AwayPlayers_Fixtures]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FK_AwayPlayers] DROP CONSTRAINT [FK_FK_AwayPlayers_Fixtures];
GO
IF OBJECT_ID(N'[dbo].[FK_FK_AwayPlayers_AwayPlayers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FK_AwayPlayers] DROP CONSTRAINT [FK_FK_AwayPlayers_AwayPlayers];
GO
IF OBJECT_ID(N'[dbo].[FK_FK_HomePlayers_Fixtures]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FK_HomePlayers] DROP CONSTRAINT [FK_FK_HomePlayers_Fixtures];
GO
IF OBJECT_ID(N'[dbo].[FK_FK_HomePlayers_HomePlayers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FK_HomePlayers] DROP CONSTRAINT [FK_FK_HomePlayers_HomePlayers];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueConfigSeason]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Seasons] DROP CONSTRAINT [FK_LeagueConfigSeason];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueLeagueConfig]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Leagues] DROP CONSTRAINT [FK_LeagueLeagueConfig];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueSeason]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Seasons] DROP CONSTRAINT [FK_LeagueSeason];
GO
IF OBJECT_ID(N'[dbo].[FK_LeaguePlayer_League]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LeaguePlayer] DROP CONSTRAINT [FK_LeaguePlayer_League];
GO
IF OBJECT_ID(N'[dbo].[FK_LeaguePlayer_Player]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LeaguePlayer] DROP CONSTRAINT [FK_LeaguePlayer_Player];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueConfigCourt_LeagueConfig]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LeagueConfigCourt] DROP CONSTRAINT [FK_LeagueConfigCourt_LeagueConfig];
GO
IF OBJECT_ID(N'[dbo].[FK_LeagueConfigCourt_Court]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LeagueConfigCourt] DROP CONSTRAINT [FK_LeagueConfigCourt_Court];
GO
IF OBJECT_ID(N'[dbo].[FK_FixtureCourt]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Fixtures] DROP CONSTRAINT [FK_FixtureCourt];
GO
IF OBJECT_ID(N'[dbo].[FK_ConfirmationPlayer]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Confirmations] DROP CONSTRAINT [FK_ConfirmationPlayer];
GO
IF OBJECT_ID(N'[dbo].[FK_ConfirmationFixture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Confirmations] DROP CONSTRAINT [FK_ConfirmationFixture];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Boxes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Boxes];
GO
IF OBJECT_ID(N'[dbo].[ContactDetails]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ContactDetails];
GO
IF OBJECT_ID(N'[dbo].[Fixtures]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Fixtures];
GO
IF OBJECT_ID(N'[dbo].[LeagueConfigs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LeagueConfigs];
GO
IF OBJECT_ID(N'[dbo].[Leagues]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Leagues];
GO
IF OBJECT_ID(N'[dbo].[Players]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Players];
GO
IF OBJECT_ID(N'[dbo].[Seasons]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Seasons];
GO
IF OBJECT_ID(N'[dbo].[Courts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Courts];
GO
IF OBJECT_ID(N'[dbo].[Confirmations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Confirmations];
GO
IF OBJECT_ID(N'[dbo].[FK_AwayPlayers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FK_AwayPlayers];
GO
IF OBJECT_ID(N'[dbo].[FK_HomePlayers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FK_HomePlayers];
GO
IF OBJECT_ID(N'[dbo].[LeaguePlayer]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LeaguePlayer];
GO
IF OBJECT_ID(N'[dbo].[LeagueConfigCourt]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LeagueConfigCourt];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Boxes'
CREATE TABLE [dbo].[Boxes] (
    [Id] uniqueidentifier  NOT NULL,
    [Number] int  NOT NULL,
    [Season_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'ContactDetails'
CREATE TABLE [dbo].[ContactDetails] (
    [Id] uniqueidentifier  NOT NULL,
    [ContactType] int  NOT NULL,
    [ContactValue] nvarchar(150)  NOT NULL,
    [Description] nvarchar(150)  NULL,
    [Player_Id] uniqueidentifier  NOT NULL
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
    [ProposedDate] datetime  NULL,
    [Status] int  NOT NULL,
    [Box_Id] uniqueidentifier  NOT NULL,
    [Court_Id] uniqueidentifier  NOT NULL
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

-- Creating table 'Leagues'
CREATE TABLE [dbo].[Leagues] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(150)  NOT NULL,
    [LeagueConfig_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'Players'
CREATE TABLE [dbo].[Players] (
    [Id] uniqueidentifier  NOT NULL,
    [FirstName] nvarchar(50)  NULL,
    [LastName] nvarchar(50)  NULL,
    [Username] nvarchar(50)  NULL,
    [Seed] int  NOT NULL
);
GO

-- Creating table 'Seasons'
CREATE TABLE [dbo].[Seasons] (
    [Id] uniqueidentifier  NOT NULL,
    [StartDate] datetime  NOT NULL,
    [EndDate] datetime  NOT NULL,
    [Description] nvarchar(150)  NOT NULL,
    [GeneratedDate] datetime  NOT NULL,
    [LeagueConfig_Id] uniqueidentifier  NOT NULL,
    [League_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'Courts'
CREATE TABLE [dbo].[Courts] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(150)  NOT NULL,
    [Sequence] int  NOT NULL
);
GO

-- Creating table 'Confirmations'
CREATE TABLE [dbo].[Confirmations] (
    [Id] uniqueidentifier  NOT NULL,
    [Status] int  NOT NULL,
    [Player_Id] uniqueidentifier  NOT NULL,
    [Fixture_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'FK_AwayPlayers'
CREATE TABLE [dbo].[FK_AwayPlayers] (
    [Fixture_Id] uniqueidentifier  NOT NULL,
    [AwayPlayers_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'FK_HomePlayers'
CREATE TABLE [dbo].[FK_HomePlayers] (
    [Fixture1_Id] uniqueidentifier  NOT NULL,
    [HomePlayers_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'LeaguePlayer'
CREATE TABLE [dbo].[LeaguePlayer] (
    [Leagues_Id] uniqueidentifier  NOT NULL,
    [Players_Id] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'LeagueConfigCourt'
CREATE TABLE [dbo].[LeagueConfigCourt] (
    [LeagueConfigs_Id] uniqueidentifier  NOT NULL,
    [Courts_Id] uniqueidentifier  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Boxes'
ALTER TABLE [dbo].[Boxes]
ADD CONSTRAINT [PK_Boxes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ContactDetails'
ALTER TABLE [dbo].[ContactDetails]
ADD CONSTRAINT [PK_ContactDetails]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Fixtures'
ALTER TABLE [dbo].[Fixtures]
ADD CONSTRAINT [PK_Fixtures]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LeagueConfigs'
ALTER TABLE [dbo].[LeagueConfigs]
ADD CONSTRAINT [PK_LeagueConfigs]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Leagues'
ALTER TABLE [dbo].[Leagues]
ADD CONSTRAINT [PK_Leagues]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Players'
ALTER TABLE [dbo].[Players]
ADD CONSTRAINT [PK_Players]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Seasons'
ALTER TABLE [dbo].[Seasons]
ADD CONSTRAINT [PK_Seasons]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Courts'
ALTER TABLE [dbo].[Courts]
ADD CONSTRAINT [PK_Courts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Confirmations'
ALTER TABLE [dbo].[Confirmations]
ADD CONSTRAINT [PK_Confirmations]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Fixture_Id], [AwayPlayers_Id] in table 'FK_AwayPlayers'
ALTER TABLE [dbo].[FK_AwayPlayers]
ADD CONSTRAINT [PK_FK_AwayPlayers]
    PRIMARY KEY NONCLUSTERED ([Fixture_Id], [AwayPlayers_Id] ASC);
GO

-- Creating primary key on [Fixture1_Id], [HomePlayers_Id] in table 'FK_HomePlayers'
ALTER TABLE [dbo].[FK_HomePlayers]
ADD CONSTRAINT [PK_FK_HomePlayers]
    PRIMARY KEY NONCLUSTERED ([Fixture1_Id], [HomePlayers_Id] ASC);
GO

-- Creating primary key on [Leagues_Id], [Players_Id] in table 'LeaguePlayer'
ALTER TABLE [dbo].[LeaguePlayer]
ADD CONSTRAINT [PK_LeaguePlayer]
    PRIMARY KEY NONCLUSTERED ([Leagues_Id], [Players_Id] ASC);
GO

-- Creating primary key on [LeagueConfigs_Id], [Courts_Id] in table 'LeagueConfigCourt'
ALTER TABLE [dbo].[LeagueConfigCourt]
ADD CONSTRAINT [PK_LeagueConfigCourt]
    PRIMARY KEY NONCLUSTERED ([LeagueConfigs_Id], [Courts_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

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

-- Creating foreign key on [Fixture_Id] in table 'FK_AwayPlayers'
ALTER TABLE [dbo].[FK_AwayPlayers]
ADD CONSTRAINT [FK_FK_AwayPlayers_Fixtures]
    FOREIGN KEY ([Fixture_Id])
    REFERENCES [dbo].[Fixtures]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [AwayPlayers_Id] in table 'FK_AwayPlayers'
ALTER TABLE [dbo].[FK_AwayPlayers]
ADD CONSTRAINT [FK_FK_AwayPlayers_AwayPlayers]
    FOREIGN KEY ([AwayPlayers_Id])
    REFERENCES [dbo].[Players]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_FK_AwayPlayers_AwayPlayers'
CREATE INDEX [IX_FK_FK_AwayPlayers_AwayPlayers]
ON [dbo].[FK_AwayPlayers]
    ([AwayPlayers_Id]);
GO

-- Creating foreign key on [Fixture1_Id] in table 'FK_HomePlayers'
ALTER TABLE [dbo].[FK_HomePlayers]
ADD CONSTRAINT [FK_FK_HomePlayers_Fixtures]
    FOREIGN KEY ([Fixture1_Id])
    REFERENCES [dbo].[Fixtures]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [HomePlayers_Id] in table 'FK_HomePlayers'
ALTER TABLE [dbo].[FK_HomePlayers]
ADD CONSTRAINT [FK_FK_HomePlayers_HomePlayers]
    FOREIGN KEY ([HomePlayers_Id])
    REFERENCES [dbo].[Players]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_FK_HomePlayers_HomePlayers'
CREATE INDEX [IX_FK_FK_HomePlayers_HomePlayers]
ON [dbo].[FK_HomePlayers]
    ([HomePlayers_Id]);
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

-- Creating foreign key on [Leagues_Id] in table 'LeaguePlayer'
ALTER TABLE [dbo].[LeaguePlayer]
ADD CONSTRAINT [FK_LeaguePlayer_League]
    FOREIGN KEY ([Leagues_Id])
    REFERENCES [dbo].[Leagues]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Players_Id] in table 'LeaguePlayer'
ALTER TABLE [dbo].[LeaguePlayer]
ADD CONSTRAINT [FK_LeaguePlayer_Player]
    FOREIGN KEY ([Players_Id])
    REFERENCES [dbo].[Players]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_LeaguePlayer_Player'
CREATE INDEX [IX_FK_LeaguePlayer_Player]
ON [dbo].[LeaguePlayer]
    ([Players_Id]);
GO

-- Creating foreign key on [LeagueConfigs_Id] in table 'LeagueConfigCourt'
ALTER TABLE [dbo].[LeagueConfigCourt]
ADD CONSTRAINT [FK_LeagueConfigCourt_LeagueConfig]
    FOREIGN KEY ([LeagueConfigs_Id])
    REFERENCES [dbo].[LeagueConfigs]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Courts_Id] in table 'LeagueConfigCourt'
ALTER TABLE [dbo].[LeagueConfigCourt]
ADD CONSTRAINT [FK_LeagueConfigCourt_Court]
    FOREIGN KEY ([Courts_Id])
    REFERENCES [dbo].[Courts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_LeagueConfigCourt_Court'
CREATE INDEX [IX_FK_LeagueConfigCourt_Court]
ON [dbo].[LeagueConfigCourt]
    ([Courts_Id]);
GO

-- Creating foreign key on [Court_Id] in table 'Fixtures'
ALTER TABLE [dbo].[Fixtures]
ADD CONSTRAINT [FK_FixtureCourt]
    FOREIGN KEY ([Court_Id])
    REFERENCES [dbo].[Courts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_FixtureCourt'
CREATE INDEX [IX_FK_FixtureCourt]
ON [dbo].[Fixtures]
    ([Court_Id]);
GO

-- Creating foreign key on [Player_Id] in table 'Confirmations'
ALTER TABLE [dbo].[Confirmations]
ADD CONSTRAINT [FK_ConfirmationPlayer]
    FOREIGN KEY ([Player_Id])
    REFERENCES [dbo].[Players]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ConfirmationPlayer'
CREATE INDEX [IX_FK_ConfirmationPlayer]
ON [dbo].[Confirmations]
    ([Player_Id]);
GO

-- Creating foreign key on [Fixture_Id] in table 'Confirmations'
ALTER TABLE [dbo].[Confirmations]
ADD CONSTRAINT [FK_ConfirmationFixture]
    FOREIGN KEY ([Fixture_Id])
    REFERENCES [dbo].[Fixtures]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ConfirmationFixture'
CREATE INDEX [IX_FK_ConfirmationFixture]
ON [dbo].[Confirmations]
    ([Fixture_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------