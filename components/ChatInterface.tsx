'use client'

import { useState, useRef, useEffect } from 'react'
import { Message } from '@/types'
import MessageBubble from './MessageBubble'
import ChatInput from './ChatInput'
import SystemMessageEditor from './SystemMessageEditor'

interface ChatInterfaceProps {
  messages: Message[]
  onSendMessage: (message: Message) => void
  conversationId: string | null
  systemMessage?: string
  onSystemMessageChange?: (message: string) => void
  model?: string
  onModelChange?: (model: string) => void
}

export default function ChatInterface({
  messages,
  onSendMessage,
  conversationId,
  systemMessage,
  onSystemMessageChange,
  model = 'grok-4-fast',
  onModelChange,
}: ChatInterfaceProps) {
  const [isLoading, setIsLoading] = useState(false)
  const [showSystemEditor, setShowSystemEditor] = useState(false)
  const messagesEndRef = useRef<HTMLDivElement>(null)

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }

  useEffect(() => {
    scrollToBottom()
  }, [messages])

  const handleSendMessage = async (content: string) => {
    if (!content.trim() || isLoading) return

    const userMessage: Message = {
      role: 'user',
      content: content.trim(),
      id: Date.now().toString(),
      timestamp: new Date().toISOString(),
    }

    onSendMessage(userMessage)
    setIsLoading(true)

    try {
      // Build messages array with system message if present
      const messagesToSend = []
      if (systemMessage && systemMessage.trim()) {
        messagesToSend.push({
          role: 'system',
          content: systemMessage.trim(),
        })
      }
      messagesToSend.push(
        ...messages.map(m => ({
          role: m.role,
          content: m.content,
        })),
        {
          role: userMessage.role,
          content: userMessage.content,
        }
      )

      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          messages: messagesToSend,
          model: model || 'grok-4-fast',
        }),
      })

      if (!response.ok) {
        throw new Error('Failed to get response from API')
      }

      const data = await response.json()
      const assistantMessage: Message = {
        role: 'assistant',
        content: data.content || 'Sorry, I could not generate a response.',
        id: (Date.now() + 1).toString(),
        timestamp: new Date().toISOString(),
      }

      onSendMessage(assistantMessage)
    } catch (error) {
      console.error('Error sending message:', error)
      const errorMessage: Message = {
        role: 'assistant',
        content: 'Sorry, there was an error processing your request. Please try again.',
        id: (Date.now() + 1).toString(),
        timestamp: new Date().toISOString(),
      }
      onSendMessage(errorMessage)
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="flex-1 flex flex-col h-full bg-white dark:bg-gray-800">
      {/* Chat Header */}
      <div className="border-b border-gray-200 dark:border-gray-700 p-4">
        <div className="flex items-center justify-between mb-2">
          <h1 className="text-xl font-semibold text-gray-800 dark:text-white">
            {conversationId ? 'Chat' : 'Start a new conversation'}
          </h1>
          {conversationId && (
            <div className="flex items-center gap-2">
              {/* Model Selector */}
              {onModelChange && (
                <select
                  value={model || 'grok-4-fast'}
                  onChange={(e) => onModelChange(e.target.value)}
                  className="px-3 py-1.5 text-sm border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
                  <option value="grok-4-fast">Grok 4 Fast</option>
                  <option value="secondmind-agent-v1">SecondMind Agent v1</option>
                </select>
              )}
              {/* System Instructions Button */}
              <button
                onClick={() => setShowSystemEditor(true)}
                className="px-3 py-1.5 text-sm bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 rounded-lg transition-colors flex items-center gap-2 text-gray-700 dark:text-gray-300"
                title="Edit system instructions"
              >
                <svg
                  className="w-4 h-4"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
                  />
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                </svg>
                {systemMessage ? 'Edit Instructions' : 'Add Instructions'}
              </button>
            </div>
          )}
        </div>
        {conversationId && (
          <div className="text-xs text-gray-500 dark:text-gray-400">
            Using {model === 'secondmind-agent-v1' ? 'SecondMind Agent v1' : 'Grok 4 Fast'} model
          </div>
        )}
      </div>
      {showSystemEditor && (
        <SystemMessageEditor
          systemMessage={systemMessage}
          onSave={(msg) => {
            if (onSystemMessageChange) {
              onSystemMessageChange(msg)
            }
            setShowSystemEditor(false)
          }}
          onClose={() => setShowSystemEditor(false)}
        />
      )}

      {/* Messages Area */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {messages.filter((m) => m.role !== 'system').length === 0 ? (
          <div className="flex items-center justify-center h-full">
            <div className="text-center text-gray-500 dark:text-gray-400">
              <svg
                className="w-16 h-16 mx-auto mb-4 opacity-50"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"
                />
              </svg>
              <p className="text-lg font-medium">Start a conversation</p>
              <p className="text-sm mt-2">Type a message below to begin chatting with Grok 4 Fast</p>
            </div>
          </div>
        ) : (
          <>
            {messages
              .filter((message) => message.role !== 'system')
              .map((message) => (
                <MessageBubble key={message.id || message.timestamp} message={message} />
              ))}
            {isLoading && (
              <div className="flex justify-start">
                <div className="bg-gray-100 dark:bg-gray-700 rounded-lg p-4 max-w-3xl">
                  <div className="flex space-x-2">
                    <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                    <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '0.2s' }}></div>
                    <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '0.4s' }}></div>
                  </div>
                </div>
              </div>
            )}
            <div ref={messagesEndRef} />
          </>
        )}
      </div>

      {/* Chat Input */}
      <ChatInput onSendMessage={handleSendMessage} disabled={isLoading} />
    </div>
  )
}

