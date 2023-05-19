#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<vector<int> > occurlist;
vector<int> freq;
vector<int> conflicts;
int decision = 0;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;


void readClauses( ) {
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);
  occurlist.resize(numVars+1); 
  freq.resize(numVars+1,0);
  conflicts.resize(numVars+1,0);
  // for (uint j = 0; j < freq.size(); ++j) cout << freq[j] << ' ';
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    
    while (cin >> lit and lit != 0) {
        clauses[i].push_back(lit);
        if (lit > 0) {
          occurlist[lit].push_back(i);
          ++freq[lit];
        }
        else {
          occurlist[-lit].push_back(i);
          ++freq[-lit];
        }
        
    }

    
  }
  // cout << "Conflicts: "  << endl;
  // for (uint j = 0; j < conflicts.size(); ++j) cout << conflicts[j] << ' ';
  // cout << endl;

  // cout << "Occurlist: "  << endl;
  // for (int i = 0; i < occurlist.size();++i) {
  //   for (int j = 0; j < occurlist[i].size(); ++j) cout << occurlist[i][j] << ' ';
  //   cout << endl;
  // }  
  
  
  
}


int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}


bool propagateGivesConflict () {
  // cout << "aaaaaaaaaaa" << endl; 
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    
    //for (int i = 0; i < modelStack.size(); ++i )  cout << modelStack[indexOfNextLitToPropagate] << ' ';
    //cout << endl;       
    ////////// MEU //////////

    int x = modelStack[indexOfNextLitToPropagate];
    
    if (x < 0) x = -x;
    //cout << "clausula lit2prop" << endl;
    vector<int> clause = occurlist[x];
    //for (uint j = 0; j < clause.size(); ++j) cout << clause[j] << ' ';
    //cout << endl;
    for (uint i = 0; i < clause.size(); ++i) {
        bool someLitTrue = false;             // de moment no podem dir que la clausula sigui certa
        int numUndefs = 0;                    // UNDEF = variables amb valors sense assignar
        int lastLitUndef = 0;                 // valor de l'ultim literal sense cap valor assignat
        
        for (uint k = 0; not someLitTrue and k < clauses[clause[i]].size(); ++k){ // anem recorrent totes les clausules on apareix el literal
          int val = currentValueInModel(clauses[clause[i]][k]);   // 
          // cout << clauses[occurlist[x][i]][k] << endl;
          if (val == TRUE) {
              someLitTrue = true;
          }
          else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[clause[i]][k]; }
          // else {
          //   ++conflicts[clauses[clause[i]][k]];
          // }
        }
        if (not someLitTrue and numUndefs == 0) { 
          // for (uint k = 0; k < clauses[clause[i]].size(); ++k) 
          //   cout << clauses[clause[i]][k] << ' ';
          // cout << endl;

          for (uint k = 0; k < clauses[clause[i]].size(); ++k) {
            ++conflicts[abs(clauses[clause[i]][k])];
          }
          return true; // conflict! all lits false
          
        }
        else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	

    }
    
    
    /////////////////////////

    /*
    for (uint i = 0; i < numClauses; ++i) { // per totes les clausules de la formula 
      bool someLitTrue = false;             // de moment no podem dir que la clausula sigui certa
      int numUndefs = 0;                    // UNDEF = variables amb valors sense assignar
      int lastLitUndef = 0;                 // valor de l'ultim literal sense cap valor assignat
      for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){
            int val = currentValueInModel(clauses[i][k]);   // 
            if (val == TRUE) someLitTrue = true;
            else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
      }
      if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
    }    
    */
   
   //cout << endl;
   ++indexOfNextLitToPropagate;
  }
  //cout << "bbbbbbbbbbb" << endl;
  return false;
}


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}


// Heuristic for finding the next decision literal:
// Agafant el que té més ocurrencies ???
int getNextDecisionLiteral(){
  ++decision;
  if (decision % 100 == 0) {
    for (int i = 0; i < conflicts.size(); ++i) conflicts[i] /= 2;
    decision = 1;
  }
  
  
  int max = -1;
  int freqmax = 0;
  int imax = 0;
  for (uint i = 1; i <= numVars; ++i) // stupid heuristic:
    if (model[i] == UNDEF && (conflicts[i] > max || (conflicts[i] == max && freqmax < freq[i]))) {
      freqmax = freq[i];
      max = conflicts[i];
      imax = i;
    } 
  return imax; // reurns 0 when all literals are defined
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      
      int val = currentValueInModel(lit);
      
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }
  
  // DPLL algorithm
  while (true) {
    
    while ( propagateGivesConflict() ) {
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack();
    }
    
    int decisionLit = getNextDecisionLiteral();
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}  