//
//  Constants.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//
import Foundation

enum Constants {
    enum Services {
        static let feelingJsonName = "feelings"
        static let feelingExtension = "json"
        static let domainError = "FeelingService"
        static let code = 1
        static let message = "Arquivo feelings.json não encontrado"
    }
    
    enum Splash {
        static let splash_image = "splash_logo"
    }

    enum Home {
        static let navigationTitle = "Sentia"
        static let title = "Como você está se sentindo?"
        static let characterLimit = 150
        static let errorLoadFeeling = "Erro ao carregar sentimentos:"
        static let groupFeelingsTitle = "Sentimentos em"
        static let understoodFeeling = "Entendi que você está se sentindo"
        static let letsListen = "Vamos ouvir um pouco sobre esse sentimento abaixo."
        static let listenAboutIt = "Ouvir sobre isso"
        static let seeMyDiary = "Ver meu diário"
        static let arrowImage = "chevron.down"
        static let because = "pois está"
    }

    enum Conversation {
        static let prompt = "Hoje estou me sentindo"
        static let title = "Sentia"
        static let savedMessageSuccess = "Salvo no diário com sucesso"
        static let understood = "Entendi que você está se sentindo"
        static let because = "pois está"
        static let loadingResponse = "Gerando resposta…"
        static let errorPrefix = "Erro:"
        static let listenButton = "Ouvir sobre isso"
        static let saveButton = "Salvar no diário"
        static let buttonIcon = "bubble.left.and.bubble.right"
        static let saveImage = "bookmark"
        static let apiURL = URL(string: "https://api.openai.com/v1/chat/completions")!
        static let authHeader = "Authorization"
        static let contentTypeHeader = "Content-Type"
        static let jsonType = "application/json"
        static let model = "gpt-3.5-turbo"
        static let temperature = 0.7
        static let maxTokens = 100
        static let fallbackMessage = "Sem resposta"
        static let systemPromptPrefix = "Você é um assistente emocional. Ajude o usuário a entender em no máximo 150 caracteres sobre se sentir"
    }
    
    enum Errors {
        static let apiKeyLoadFailure = "Não foi possível carregar o token da OpenAI."
    }

    enum Diary {
        static let title = "Diário"
        static let emptyStateMessage = "Nenhum registro salvo ainda."
    }

    enum Common {
        static let appName = "Sentia"
        static let defaultAnimationDuration: TimeInterval = 0.25
    }
    
    enum Cache {
        static let diaryEntriesFile = "diary_entries"
        static let failedToSave = "❌ Failed to save cache: "
    }
}
