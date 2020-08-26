


//Werewolf player roles

var RolesEnum = { 
  // THE MAFIA
  MAFIA: "Mafia",

  BARMAN:  "The Barman",
  BANDIT: "The Bandit",
  RAMBO: "Rambo",
  ANTI_DOCTOR: "Anti-Doctor",
  
  //THE INNOCENTS
  INNOCENT: "Innocent",
  
  DETECTIVE: "The Detective",
  DOCTOR: "The Doctor",
  
  VIGILANTE: "The Vigilante",
  MAGICIAN: "The Magician",
  VETERAN:  "The Veteran",
  CUPID_AND_THE_LOVERS: "Cupid And The Lovers",
  ARMOR: "The Armor",
  
  //BOTH
  LYCAN: "The Lycan",
  LAWYER: "The Lawyer",

  //NITHER
  PEEPING_TOM: "The Peeping-Tom",
  INFORMANT: "The Informant",
  BUS_DRIVER: "The Bus Driver",
  OTHER_ALIEN: "The Other (Alien)",
  //THE MODERATOR//
}

let game = class Game {
    ////////
    //NOTS//
    ///////
    //-Game will get number of players (total) and number of mafia
    //-The uninformed majority (the innocents) should know howmany mafia are there!
    //-the original Davidoff rules suggest a third of the players (rounding to the nearest whole number) be mafiosi.
    
    constructor(totalPlayers){
        // invokes the setter
        this.totalPlayers = totalPlayers;
        this.arrayOfRoles = [];
        this.players = [];
        this.numberOfMafia = 0;
        this.gameCode;

        //This array will have intergers from 1 to 3; 1 code for innocent, 2 code for mafia and 3 code for other
        this.arrayOfGroupForEachRole = []

      }


    getRandom(max) {
        return Math.floor(Math.random() * Math.floor(max));
    }
    //Genrates a random code of 5 digets/letters that will be the game code, God willing
    randomCode() {
        return Math.random().toString(36).substr(2, 5).toUpperCase();
          }

    creatingArrayOfPlayers(roles){
        for (let i = 0; i < this.totalPlayers; i++) {
          this.players.push({status: true, id: 'none', name: 'none', role: roles[i], group: this.arrayOfGroupForEachRole[i]});
        }
      
      }

    //returns number of players in proportion to the total number of players
    numberOfMafiso(x){ 

        if ((x > 4 && x < 25) && (this.numberOfMafia === 0)) {
            return Math.round(x / 3);
        } else {
            return 0;
        }

    }
    //Creat an array of innocent players onley, the lenth of it is equal to the total number of players
    firstArrayOfInnocent(){
        for(let i = 0; i < (this.totalPlayers); i++){
            this.arrayOfRoles.push(RolesEnum.INNOCENT);
            this.arrayOfGroupForEachRole.push(1);
        }
    }
    //This method will randmoly pick a an innocent from the first array of and replace it with a mafia.
    replacingInnocentsFromFirstArrayWithMafia(){

        for(let i = 1; i <= this.numberOfMafia + 2;){
            var randomIndex = this.getRandom(this.totalPlayers);
        
            if (this.arrayOfRoles[randomIndex] === RolesEnum.INNOCENT) {
                
                if (i <= this.numberOfMafia) {
                    this.arrayOfRoles[randomIndex] = RolesEnum.MAFIA;
                    this.arrayOfGroupForEachRole[randomIndex] = 2
                }
                if (i === this.numberOfMafia + 1){
                    this.arrayOfRoles[randomIndex] = RolesEnum.DOCTOR;
                }
                if (i === this.numberOfMafia + 2){
                    this.arrayOfRoles[randomIndex] = RolesEnum.DETECTIVE;
                }

            i++;
            }
        }

    }
    //Creat an array of players that was randomlly indexed the players/ rules are set to defult
    creatDataToBewrote(){
       
        this.numberOfMafia = this.numberOfMafiso(this.totalPlayers);
        this.gameCode = this.randomCode();

        this.firstArrayOfInnocent()
        this.replacingInnocentsFromFirstArrayWithMafia() 

        this.creatingArrayOfPlayers(this.arrayOfRoles);

    }

    //Edite role function

}

module.exports = game;

