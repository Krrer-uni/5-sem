#include "program.h"


int main(int argc, char *argv[])
{

  if(argc!=2)
    {
      program_usage();
      exit(EXIT_FAILURE);
    }

  {
    int idx=atoi(argv[1]);
    switch( idx )
      {
      case 0:
        s0_podprogram() ; // podprogram studenta o numerze indeksu 0
        break;
      case 999:
        s999_podprogram() ; // podprogram studenta o numerze indeksu 999
        break;
      case 261737:
        s261737_podprogram() ; // podprogram studenta o numerze indeksu 261737
        break;
      case 254648:
        s254648_podprogram() ; // podprogram studenta o numerze indeksu 254648
        break;
      default:
	printf("\nStudent o numerze indeksu %d nie wykonał jeszcze zadania\n\n",idx); 
      break;

      }
  }
  exit(EXIT_SUCCESS);
}
