# Stack Paint - On-Chain Pixel Art Canvas

A decentralized pixel art platform built on the Stacks blockchain that allows users to create and own pixel art directly on-chain.

## Overview

Stack Paint is a 32x32 pixel canvas where users can:
- Paint individual pixels by burning STX tokens
- Own their pixel placements on the blockchain
- View the history of pixel updates
- Query pixel ownership and colors

## Technical Details

### Smart Contract Features
- 32x32 grid (1024 total pixels)
- Cost per pixel: 0.0001 STX
- Tracking system for pixel updates
- Built with Clarity smart contracts

### Contract Functions

```clarity
// Main painting function
(define-public (paint-pixel (x uint) (y uint) (color int))
```
- Validates coordinates
- Burns STX tokens
- Updates pixel ownership
- Tracks modification history

### Data Structure
- Pixels stored in map with coordinates as keys
- Each pixel contains:
  - Color value
  - Owner address
  - Last update count

## Getting Started

### Prerequisites
- Stacks wallet
- STX tokens for painting
- Node.js and npm

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/stack-paint.git
cd stack-paint
```

2. Install dependencies
```bash
npm install
```

## Development

### Testing
```bash
npm test
```

### Deploying
```bash
npm run deploy
```
