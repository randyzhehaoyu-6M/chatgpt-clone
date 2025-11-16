# ChatGPT Clone

A modern ChatGPT-like interface built with Next.js, TypeScript, and Tailwind CSS. This application integrates with the AI Builders API to provide chat functionality using the Grok 4 Fast model.

## Features

- **Two-Column Layout**: Conversations sidebar on the left, chat interface on the right
- **Multiple Conversations**: Create, manage, and switch between multiple conversations
- **Real-time Chat**: Send messages and receive responses from Grok 4 Fast model
- **Persistent Storage**: Conversations are saved to localStorage
- **Modern UI**: Clean, responsive design with dark mode support
- **TypeScript**: Fully typed for better development experience

## Getting Started

### Prerequisites

- Node.js 18+ and npm/yarn/pnpm

### Installation

1. Install dependencies:
```bash
npm install
```

2. Set up environment variables:
The `.env.local` file has been created with the necessary API token. Make sure it exists and contains:
```
AI_BUILDER_TOKEN=your_token_here
NEXT_PUBLIC_API_BASE_URL=https://space.ai-builders.com/backend
```

3. Run the development server:
```bash
npm run dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Project Structure

```
├── app/
│   ├── api/
│   │   └── chat/
│   │       └── route.ts          # API route for chat completions
│   ├── globals.css               # Global styles
│   ├── layout.tsx                # Root layout
│   └── page.tsx                  # Main page component
├── components/
│   ├── ChatInput.tsx             # Chat input component
│   ├── ChatInterface.tsx         # Main chat interface
│   ├── MessageBubble.tsx         # Individual message component
│   └── Sidebar.tsx               # Conversations sidebar
├── types/
│   └── index.ts                  # TypeScript type definitions
└── package.json
```

## Usage

1. **Start a New Conversation**: Click the "New Chat" button in the sidebar
2. **Send Messages**: Type your message in the input field and press Enter or click Send
3. **Switch Conversations**: Click on any conversation in the sidebar to switch to it
4. **Delete Conversations**: Hover over a conversation and click the delete icon

## API Integration

This application uses the AI Builders API with the following configuration:
- **Base URL**: `https://space.ai-builders.com/backend`
- **Model**: `grok-4-fast`
- **Authentication**: Bearer token via `AI_BUILDER_TOKEN` environment variable

## Technologies Used

- **Next.js 14**: React framework with App Router
- **TypeScript**: Type safety
- **Tailwind CSS**: Utility-first CSS framework
- **OpenAI SDK**: For API integration (OpenAI-compatible)

## License

MIT

