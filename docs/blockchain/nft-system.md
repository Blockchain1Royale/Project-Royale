# NFT System

## Overview

The Project Royale NFT system is built on Solana's Metaplex standard, providing a robust foundation for in-game assets.

## NFT Categories

### 1. Character Skins
```json
{
  "name": "Elite Warrior",
  "symbol": "RWRR",
  "description": "Legendary warrior skin with custom effects",
  "attributes": {
    "rarity": "Legendary",
    "season": "1",
    "type": "Character",
    "effects": ["Trail", "Aura"],
    "abilities": ["Double Jump", "Silent Movement"]
  }
}
```

### 2. Weapon Skins
```json
{
  "name": "Dragon's Breath AR",
  "symbol": "DBAR",
  "description": "Mythical assault rifle with fire effects",
  "attributes": {
    "rarity": "Mythical",
    "weapon_type": "Assault Rifle",
    "effects": ["Fire Trail", "Kill Effect"],
    "stats_tracking": true
  }
}
```

### 3. Building Materials
```json
{
  "name": "Crystal Walls",
  "symbol": "CWAL",
  "description": "Transparent building material with special effects",
  "attributes": {
    "rarity": "Epic",
    "material_type": "Walls",
    "effects": ["Transparency", "Build Animation"],
    "durability_bonus": 10
  }
}
```

## Implementation

### 1. NFT Creation
```rust
pub fn create_nft(
    ctx: Context<CreateNFT>,
    metadata: NFTMetadata,
    attributes: NFTAttributes,
) -> Result<()> {
    // NFT creation logic using Metaplex
}

#[derive(AnchorSerialize, AnchorDeserialize)]
pub struct NFTMetadata {
    pub name: String,
    pub symbol: String,
    pub uri: String,
}

#[derive(AnchorSerialize, AnchorDeserialize)]
pub struct NFTAttributes {
    pub rarity: String,
    pub nft_type: NFTType,
    pub effects: Vec<String>,
}
```

### 2. In-Game Integration
```rust
pub fn equip_nft(
    ctx: Context<EquipNFT>,
    nft_mint: Pubkey,
    slot: EquipmentSlot,
) -> Result<()> {
    // Equipment logic
}

pub fn verify_nft_ownership(
    ctx: Context<VerifyNFT>,
    nft_mint: Pubkey,
) -> Result<bool> {
    // Ownership verification
}
```

## Rarity System

### 1. Rarity Tiers
```rust
#[derive(AnchorSerialize, AnchorDeserialize)]
pub enum RarityTier {
    Common,    // 50%
    Uncommon,  // 25%
    Rare,      // 15%
    Epic,      // 7%
    Legendary, // 2.5%
    Mythical,  // 0.5%
}

pub fn calculate_drop_chance(rarity: RarityTier) -> f64 {
    match rarity {
        RarityTier::Common => 0.50,
        RarityTier::Uncommon => 0.25,
        RarityTier::Rare => 0.15,
        RarityTier::Epic => 0.07,
        RarityTier::Legendary => 0.025,
        RarityTier::Mythical => 0.005,
    }
}
```

## Marketplace Integration

### 1. Listing NFTs
```rust
pub fn list_nft(
    ctx: Context<ListNFT>,
    nft_mint: Pubkey,
    price: u64,
) -> Result<()> {
    // Listing logic
}
```

### 2. Trading System
```rust
pub fn execute_trade(
    ctx: Context<Trade>,
    listing_id: Pubkey,
) -> Result<()> {
    // Trade execution logic
}
```

## Upgrade System

### 1. NFT Evolution
```rust
pub fn evolve_nft(
    ctx: Context<EvolveNFT>,
    nft_mint: Pubkey,
    evolution_materials: Vec<Pubkey>,
) -> Result<()> {
    // Evolution logic
}
```

### 2. Attribute Enhancement
```rust
pub fn enhance_attributes(
    ctx: Context<EnhanceNFT>,
    nft_mint: Pubkey,
    attribute: String,
    materials: Vec<Pubkey>,
) -> Result<()> {
    // Enhancement logic
}
```

## Console Integration

### 1. Hardware Acceleration
```rust
pub fn verify_console_nft(
    ctx: Context<ConsoleNFT>,
    console_id: Pubkey,
    nft_mint: Pubkey,
) -> Result<()> {
    // Console-specific verification
}
```

### 2. Exclusive Features
```rust
pub fn activate_console_bonus(
    ctx: Context<ConsoleBonus>,
    nft_mint: Pubkey,
) -> Result<()> {
    // Console-specific bonuses
}
``` 