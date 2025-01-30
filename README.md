# ImpactDAO: Decentralized Crowdfunding & Grant Management

ImpactDAO is a blockchain-based platform that revolutionizes crowdfunding and grant management through transparent fund allocation, automated milestone-based disbursements, and real-time impact tracking.

## Features

### Campaign Management
- Permissionless campaign creation with customizable funding goals
- Multi-signature approval system for campaign verification
- Flexible funding models (all-or-nothing, keep-what-you-raise)
- Integrated impact measurement and reporting tools

### Smart Contract Infrastructure
- Automated fund distribution based on milestone completion
- Escrow system for donor protection
- Democratic governance for funding decisions
- Real-time financial transparency and reporting

### Impact Tracking
- Standardized impact metrics across project categories
- Integration with external data oracles for verification
- Automated progress reporting and milestone validation
- Real-time dashboard for impact visualization

### Donor Engagement
- NFT-based contribution certificates
- Voting rights proportional to contribution
- Direct communication channel with project creators
- Portfolio tracking of supported projects

## Technical Architecture

### Core Components
- Ethereum smart contracts for fund management
- TheGraph for indexed data and analytics
- IPFS for decentralized storage
- React frontend with Web3 integration

### Smart Contracts
```solidity
// Core interfaces
interface ICampaignFactory {
    function createCampaign(
        string memory title,
        uint256 goal,
        uint256 duration,
        address[] memory validators
    ) external returns (address);
}

interface ICampaign {
    function contribute() external payable;
    function withdrawMilestone(uint256 milestoneId) external;
    function validateMilestone(uint256 milestoneId) external;
    function refund() external;
}

interface IImpactOracle {
    function submitMetrics(bytes32 projectId, bytes32[] metrics) external;
    function validateMetrics(bytes32 projectId) external returns (bool);
}
```

### API Endpoints
- `POST /api/v1/campaigns`: Create new campaign
- `GET /api/v1/campaigns/{id}`: Get campaign details
- `POST /api/v1/milestones/{id}/validate`: Validate milestone
- `GET /api/v1/impact/{id}`: Retrieve impact metrics

## Getting Started

### Prerequisites
- Node.js v16+
- Hardhat for smart contract development
- Web3 wallet (MetaMask recommended)
- IPFS node (optional)

### Installation
1. Clone the repository:
```bash
git clone https://github.com/your-org/impactdao.git
cd impactdao
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env
# Configure your environment variables
```

4. Deploy smart contracts:
```bash
npx hardhat run scripts/deploy.js --network <your-network>
```

5. Start the development server:
```bash
npm run dev
```

### Configuration
Required environment variables:
```
ETHEREUM_RPC_URL=your-ethereum-node
IPFS_API_URL=your-ipfs-node
THE_GRAPH_API_KEY=your-api-key
ORACLE_ADDRESS=impact-oracle-address
```

## Usage Examples

### Creating a Campaign
```javascript
const impactDAO = new ImpactDAO(config);

// Initialize new campaign
const campaign = await impactDAO.createCampaign({
    title: "Community Solar Project",
    description: "Installing solar panels in underserved areas",
    goal: ethers.utils.parseEther("100"),
    duration: 30 * 24 * 60 * 60, // 30 days
    milestones: [
        {
            description: "Equipment Purchase",
            amount: ethers.utils.parseEther("40"),
            metrics: ["EQUIPMENT_ORDERED", "DELIVERY_CONFIRMED"]
        },
        {
            description: "Installation",
            amount: ethers.utils.parseEther("60"),
            metrics: ["INSTALLATION_COMPLETE", "POWER_GENERATION_STARTED"]
        }
    ]
});
```

### Tracking Impact Metrics
```javascript
// Submit impact metrics
await impactDAO.submitMetrics(campaign.id, {
    beneficiaries: 150,
    kwhGenerated: 1000,
    co2Reduced: 750
});
```

## Impact Measurement

ImpactDAO supports various standardized impact metrics:
- Social impact indicators
- Environmental metrics
- Economic development measures
- Community engagement metrics

Each metric is:
- Independently verifiable
- Time-stamped on-chain
- Linked to specific milestones
- Accessible via API

## Governance

The platform implements a DAO structure for:
- Campaign approval
- Milestone validation
- Protocol upgrades
- Parameter adjustments

Governance rights are distributed to:
- Active donors
- Project creators
- Community validators

## Security

- Smart contract audits by leading firms
- Bug bounty program
- Regular security assessments
- Multi-signature requirements for critical operations

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Development guidelines
- Testing requirements
- Code review process
- Security practices

## License

Licensed under MIT - see [LICENSE](LICENSE)

## Support & Resources

- Documentation: [docs.impactdao.io](https://docs.impactdao.io)
- Discord: [ImpactDAO Community](https://discord.gg/impactdao)
- Twitter: [@ImpactDAO](https://twitter.com/impactdao)
- Email: support@impactdao.io
