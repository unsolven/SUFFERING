-- Carrega a biblioteca LoUI do repositório do GitHub
local LoUILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/unsolven/SUFFERING/refs/heads/main/LoUI.lua"))()

-- Cria uma nova janela e define seu título e tema
local window = LoUILibrary:Load("LoUI Hub!")

-- Cria a primeira aba com um ID de imagem
local tab1 = LoUILibrary.newTab("Jogadores", "rbxassetid://13529337034")

-- Adiciona elementos à primeira aba
tab1.newLabel("Olá, esta é a Aba 1.")
tab1.newButton("Botão", "Imprime Olá!", function()
    print('Olá!')
end)
tab1.newToggle("Alternar", "Alternar! (imprime o estado)", true, function(toggleState)
    if toggleState then
        print("Ligado")
    else
        print("Desligado")
    end
end)
tab1.newInput("Entrada", "Imprime sua entrada.", function(text)
    print("Texto inserido na Aba 1: " .. text)
end)

-- Cria a segunda aba com um ID de imagem diferente
local tab2 = LoUILibrary.newTab("Mundo", "rbxassetid://13529340637")

-- Adiciona elementos à segunda aba
tab2.newLabel("Olá, esta é a Aba 2.")
tab2.newButton("Botão 2", "Imprime Olá também!", function()
    print('Olá também!')
end)
tab2.newToggle("Alternar 2", "Alternar! (imprime o estado)", true, function(toggleState)
    if toggleState then
        print("Ligado 2")
    else
        print("Desligado 2")
    end
end)
tab2.newDropdown("Dropdown", "Selecione uma destas opções!", {"água", "cachorro", "ar", "bb", "avião", "wohhho", "yeay", "deletar"}, function(selectedOption)
    print(selectedOption)
end)
