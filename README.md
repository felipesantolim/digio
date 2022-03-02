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
        <img src="https://avatars3.githubusercontent.com/u/31936044" width="100px;" alt="Foto do Iuri Silva no GitHub"/><br>
        <sub>
          <b>Iuri Silva</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
