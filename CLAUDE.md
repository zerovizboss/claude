# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Salesforce DX project named "TheKenificGroup" configured for API version 64.0. The project follows standard Salesforce development patterns and includes OmniStudio components for advanced UI development.

## Key Development Commands

### Salesforce CLI Commands
- `sf org create scratch --definition-file config/project-scratch-def.json --alias myorg` - Create scratch org
- `sf project deploy start` - Deploy metadata to org  
- `sf project retrieve start` - Retrieve metadata from org
- `sf apex run test` - Run Apex tests
- `sf apex run test --class-names MyIterableTest` - Run specific test class
- `sf data import tree --plan data-plan.json` - Import test data

### Code Quality & Testing
- `npm run lint` - Lint JavaScript/LWC code using ESLint
- `npm run test` - Run LWC Jest unit tests
- `npm run test:unit:watch` - Run tests in watch mode
- `npm run test:unit:coverage` - Run tests with coverage report
- `npm run prettier` - Format all code files
- `npm run prettier:verify` - Check code formatting

## Architecture & Structure

### Metadata Organization
The project uses standard Salesforce DX structure with metadata organized under `force-app/main/default/`:

- **Apex Classes**: Located in `classes/` - Contains business logic and test classes
- **Lightning Web Components**: Located in `lwc/` - Custom UI components  
- **Objects & Fields**: Extensive custom object definitions in `objects/`
- **OmniStudio Components**: Includes DataRaptors, OmniScripts, and FlexCards for advanced UI flows
- **Permission Management**: Role hierarchy and permission sets for security
- **Standard Value Sets**: Customized picklist values for various industries

### Key Components

**OmniStudio Integration**: The project heavily utilizes Salesforce Industries (OmniStudio) components:
- DataRaptor for data transformation
- OmniScript for guided user experiences  
- FlexCards for responsive UI components
- Document templates and digital asset management

**Industry-Specific Objects**: Contains extensive metadata for:
- Public Sector applications (licensing, permitting, inspections)
- Healthcare (accreditation, practitioners)
- Financial Services (accounts, assets)
- Field Service (work orders, appointments, resources)

**Business Process Support**: 
- Approval processes and workflow automation
- Case management and complaint handling
- Asset and inventory management
- Regulatory compliance tracking

### Development Environment

- **IDE Integration**: Configured for IntelliJ IDEA with Illuminated Cloud plugin
- **Code Quality**: Pre-commit hooks with Husky, lint-staged for automated formatting
- **Testing Framework**: LWC Jest for component testing, Apex testing framework
- **Source Control**: Git-based with appropriate .forceignore patterns

### Custom Development

**Apex Classes**: 
- `MyIterable` - Example iterable implementation with corresponding test class
- Test classes follow `@IsTest` annotation pattern

**Lightning Web Components**:
- `pkpassConverter` - Component for handling pkpass file conversion
- Standard LWC structure with proper metadata files

## Configuration Notes

- Scratch org definition enables Lightning Experience and password API features
- ESLint configured for Salesforce-specific rules and LWC best practices
- Prettier configured for consistent code formatting across multiple file types
- Source API version set to 64.0 (Winter '25)

## Deployment Considerations

The project includes comprehensive metadata for enterprise-level Salesforce implementations with:
- Multi-industry support (Public Sector, Healthcare, Financial Services)
- Complex permission structures and role hierarchies  
- Advanced UI components through OmniStudio
- Extensive custom object relationships and business processes