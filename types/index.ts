export interface Message {
  role: 'user' | 'assistant' | 'system'
  content: string
  id?: string
  timestamp?: string
}

export interface Conversation {
  id: string
  title: string
  messages: Message[]
  systemMessage?: string
  model?: string
  createdAt: string
  updatedAt?: string
}

export type Model = 'grok-4-fast' | 'secondmind-agent-v1'

