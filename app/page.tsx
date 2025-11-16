'use client'

import { useState, useEffect } from 'react'
import Sidebar from '@/components/Sidebar'
import ChatInterface from '@/components/ChatInterface'
import { Conversation, Message } from '@/types'

export default function Home() {
  const [conversations, setConversations] = useState<Conversation[]>([])
  const [activeConversationId, setActiveConversationId] = useState<string | null>(null)
  const [messages, setMessages] = useState<Message[]>([])

  // Load conversations from localStorage on mount
  useEffect(() => {
    const savedConversations = localStorage.getItem('conversations')
    if (savedConversations) {
      const parsed = JSON.parse(savedConversations)
      setConversations(parsed)
      if (parsed.length > 0) {
        setActiveConversationId(parsed[0].id)
        setMessages(parsed[0].messages)
      }
    }
  }, [])

  // Save conversations to localStorage whenever they change
  useEffect(() => {
    if (conversations.length > 0) {
      localStorage.setItem('conversations', JSON.stringify(conversations))
    }
  }, [conversations])

  // Update messages when active conversation changes
  useEffect(() => {
    if (activeConversationId) {
      const conversation = conversations.find(c => c.id === activeConversationId)
      if (conversation) {
        setMessages(conversation.messages)
      }
    } else {
      setMessages([])
    }
  }, [activeConversationId, conversations])

  const createNewConversation = () => {
    const newConversation: Conversation = {
      id: Date.now().toString(),
      title: 'New Conversation',
      messages: [],
      model: 'grok-4-fast',
      createdAt: new Date().toISOString(),
    }
    setConversations([newConversation, ...conversations])
    setActiveConversationId(newConversation.id)
    setMessages([])
  }

  const selectConversation = (id: string) => {
    setActiveConversationId(id)
  }

  const deleteConversation = (id: string) => {
    const updated = conversations.filter(c => c.id !== id)
    setConversations(updated)
    if (activeConversationId === id) {
      if (updated.length > 0) {
        setActiveConversationId(updated[0].id)
      } else {
        setActiveConversationId(null)
        setMessages([])
      }
    }
  }

  const updateConversationTitle = (id: string, title: string) => {
    setConversations(conversations.map(c => 
      c.id === id ? { ...c, title } : c
    ))
  }

  const generateTitle = async (firstMessage: string): Promise<string> => {
    try {
      const response = await fetch('/api/generate-title', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ firstMessage }),
      })
      const data = await response.json()
      return data.title || firstMessage.substring(0, 50) || 'New Conversation'
    } catch (error) {
      console.error('Error generating title:', error)
      return firstMessage.substring(0, 50) || 'New Conversation'
    }
  }

  const addMessage = async (message: Message) => {
    if (!activeConversationId) {
      // Create a new conversation if none is active
      let title = 'New Conversation'
      if (message.role === 'user') {
        title = await generateTitle(message.content)
      }
      const newConversation: Conversation = {
        id: Date.now().toString(),
        title,
        messages: [message],
        model: 'grok-4-fast',
        createdAt: new Date().toISOString(),
      }
      setConversations([newConversation, ...conversations])
      setActiveConversationId(newConversation.id)
      // Messages will be updated by useEffect
    } else {
      // Add message to active conversation
      setConversations(prev => {
        const updated = prev.map(c => {
          if (c.id === activeConversationId) {
            const updatedMessages = [...c.messages, message]
            // Generate title if it's the first user message
            let title = c.title
            if (c.title === 'New Conversation' && message.role === 'user') {
              // Generate title asynchronously
              generateTitle(message.content).then((generatedTitle) => {
                setConversations(current => current.map(conv => 
                  conv.id === c.id ? { ...conv, title: generatedTitle } : conv
                ))
              })
              title = message.content.substring(0, 50) || 'New Conversation' // Temporary title
            }
            return {
              ...c,
              title,
              messages: updatedMessages,
            }
          }
          return c
        })
        // Update messages state from the updated conversation
        const activeConv = updated.find(c => c.id === activeConversationId)
        if (activeConv) {
          setMessages(activeConv.messages)
        }
        return updated
      })
    }
  }

  const updateSystemMessage = (id: string, systemMessage: string) => {
    setConversations(conversations.map(c => 
      c.id === id ? { ...c, systemMessage } : c
    ))
  }

  const updateModel = (id: string, model: string) => {
    setConversations(conversations.map(c => 
      c.id === id ? { ...c, model } : c
    ))
  }

  return (
    <div className="flex h-screen bg-gray-50 dark:bg-gray-900">
      <Sidebar
        conversations={conversations}
        activeConversationId={activeConversationId}
        onSelectConversation={selectConversation}
        onNewConversation={createNewConversation}
        onDeleteConversation={deleteConversation}
      />
      <ChatInterface
        messages={messages}
        onSendMessage={addMessage}
        conversationId={activeConversationId}
        systemMessage={conversations.find(c => c.id === activeConversationId)?.systemMessage}
        onSystemMessageChange={(msg) => {
          if (activeConversationId) {
            updateSystemMessage(activeConversationId, msg)
          }
        }}
        model={conversations.find(c => c.id === activeConversationId)?.model || 'grok-4-fast'}
        onModelChange={(model) => {
          if (activeConversationId) {
            updateModel(activeConversationId, model)
          }
        }}
      />
    </div>
  )
}

