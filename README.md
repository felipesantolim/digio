# iOS Developer Digio

### MVVM + Coordinator + RXSwift + XCode 13.2 + iOS 14+

Utilizei os seguintes pacotes SPM:

- [x] Kingsfisher 7.2.0
- [x] Lottie 3.3.0
- [x] RxSwift 6.5.0

## 💻 Bibliotecas utilizadas:

1. Kingsfisher: utilizei para realizar o download e cache das imagens retornadas pela API, gosto muito dessa biblioteca que é uma evolução de SDWebImage da época do Objective-C

2. Lottie: utilizei apenas para criar uma animação (customizada) de loading na home através de um JSON de lottie files.

3. RxSwift: utilizei junto ao MVVM-C pois acredito ser uma das melhores opções junto a arquitetura, facilitando binds, drivers, relays e claro a aplicação do RxCocoa nos compnentes do iOS facilitando a construção do mesmo.

## 📝 Projeto:

Criei e configurei o projeto sem storyboard e scene por default.

Separei o app em Sections e Supporting Files:

### Sections: 

Cada section possui as abstrações (no minimo): 

- [x] View
- [x] ViewModel
- [x] Flow

1. View: Parte visual, viewcontroller, cells, customs views etc.
2. ViewModel: Responsável por aplicar a logica de negócio dentro da view.
3. Flow: Abstração do fluxo de navegação e responsável por fazer a injeção de dependência do flow seguinte se necessário.

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/felipesantolim/digio/blob/main/app-imgs/Screen%20Shot%202022-03-01%20at%2021.53.15.png" width="300px;" alt=""/><br>
        <sub>
          <b>Digio App - MVVM</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

## 🚀 Protótipo App Digio:

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/felipesantolim/digio/blob/main/app-imgs/Screen%20Shot%202022-03-01%20at%2021.04.31.png" width="300px;" alt=""/><br>
        <sub>
          <b>Digio App - MVVM</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

## 📝 Curiosidades:

- [x] Generics 
- [x] Extensions

### Generics: Criei um generics base para ficar mais simples a abstração das células customizadas.

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/felipesantolim/digio/blob/main/app-imgs/Screen%20Shot%202022-03-01%20at%2022.08.22.png" width="300px;" alt=""/><br>
        <sub>
          <b>Digio App - MVVM</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

### Extensions: Criei algumas extensions para facilitar o uso do flow, collection e classname.

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/felipesantolim/digio/blob/main/app-imgs/Screen%20Shot%202022-03-01%20at%2022.08.03.png" width=300px;" alt=""/><br>
        <sub>
          <b>Digio App - MVVM</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
                                                                                                                                                 
### BaseCollectionViewCell:
                                                                                                                                                 
<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://github.com/felipesantolim/digio/blob/main/app-imgs/Screen%20Shot%202022-03-01%20at%2022.12.02.png" width=300px;" alt=""/><br>
        <sub>
          <b>Digio App - MVVM</b>
        </sub>
      </a>
    </td>
  </tr>
</table> 

## ☕ + Plus:

- [x] ViewCode 
- [x] URLSession
- [x] Codable

## ☕ O que faria com + tempo:

- [x] Mais um nível de abstração da view em relação a view controller.
- [x] Testes Unitários.
- [x] Testes UI.
- [x] Tratamento de erros.
- [x] Fix "layout" (melhorias).

## 🚀🚀🚀 Protótipo App Digio (movie) 🚀🚀🚀 :

https://user-images.githubusercontent.com/3669521/156277050-7f97dffd-5a39-4d71-82a7-0cc517ab810a.mov
