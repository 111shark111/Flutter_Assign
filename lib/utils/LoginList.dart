import 'dart:core';

class LoginList {
  static List<String> userList = ['user1', 'user2', 'user3'];
  static List<String> passList = ['user1@123', 'user2@123', 'user3@123'];
  static List<Map<String, String>> userData = [
    {
      'name': 'user1',
      'password': 'passUser1',
      'eloRating': '2200',
      'profilePic':
          'https://media.istockphoto.com/photos/middle-aged-man-portrait-picture-id1285156699',
      'T_played': '34',
      'T_won': '9',
      'T_percent': '26'
    },
    {
      'name': 'user2',
      'password': 'passUser2',
      'eloRating': '2400',
      'profilePic':
          'https://media.istockphoto.com/photos/senior-man-portrait-picture-id1285138581',
      'T_played': '43',
      'T_won': '15',
      'T_percent': '34'
    },
    {
      'name': 'user3',
      'password': 'passUser3',
      'eloRating': '2130',
      'profilePic':
          'https://media.istockphoto.com/photos/young-man-picture-id162355500',
      'T_played': '54',
      'T_won': '27',
      'T_percent': '50'
    },
  ];
}


// const LoginData = [
//     {
//         name: 'user1',
//         password: 'passUser1',
//         eloRating: 2200,
//         profilePic: 'https://media.istockphoto.com/photos/middle-aged-man-portrait-picture-id1285156699',
//         T_played: 34,
//         T_won: 9,
//         T_percent: 26
//     },
//     {
//         name: 'user2',
//         password: 'passUser2',
//         eloRating: 2400,
//         profilePic: 'https://media.istockphoto.com/photos/senior-man-portrait-picture-id1285138581',
//         T_played: 43,
//         T_won: 15,
//         T_percent: 34
//     },
//     {
//         name: 'user3',
//         password: 'passUser3',
//         eloRating: 2130,
//         profilePic: 'https://media.istockphoto.com/photos/young-man-picture-id162355500',
//         T_played: 54,
//         T_won: 27,
//         T_percent: 50
//     },
// ]

// export default LoginData