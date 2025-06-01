# AutoHeritage: Classic Automobile Authentication and Registry Platform

AutoHeritage is a decentralized automobile registry built on blockchain technology that enables enthusiasts and collectors to authenticate, register, and track classic and vintage automobiles.

## Overview

AutoHeritage creates a trusted platform for automotive enthusiasts to document and preserve automotive heritage. The platform allows collectors to register vehicles with verifiable details like model year and restoration status, establishing provenance and authenticity for valuable classic automobiles.

## Features

- Register classic automobiles with detailed information (model, history, manufacturer, restoration)
- Document model year for accurate dating and historical significance
- Manage garage status for vehicle inventory
- Browse vehicles by manufacturer, restoration level, era, or enthusiast
- Transparent ownership tracking and automotive provenance

## Contract Functions

### Public Functions

- `register-automobile`: Register a classic automobile in the heritage registry
- `retire-automobile`: Mark a vehicle as retired from active collection
- `get-automobile`: Retrieve details about a specific classic vehicle
- `get-enthusiast`: Get the enthusiast who registered a specific automobile

### Constants

- Minimum model year validation (1885 - birth of the automobile)
- Validation for manufacturers and restoration levels
- Error codes for various failure scenarios

## Data Structure

Each automobile entry contains:
- Enthusiast information (principal)
- Model name (string)
- Vehicle history and documentation (string)
- Manufacturer classification
- Restoration level assessment
- Garage status
- Model year

## Getting Started

To interact with the AutoHeritage registry:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. Register your classic automobiles to establish provenance
4. Browse registered vehicles from other enthusiasts and collectors

## Future Development

- Implement vehicle trading functionality
- Add professional appraisal system
- Create automotive valuation and appreciation tracking
- Develop virtual garage showcases and restoration documentation