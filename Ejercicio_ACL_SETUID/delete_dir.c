#include <string.h>
#include <errno.h>
#include <stdio.h>

int main (int argc, char ** argv) 
{
	const char directorio[] = "/home/ej1/esb";
	
	printf("Intentando borrar el directorio '%s' ...\n", directorio);

	if (rmdir(directorio) == 0) 
	{
		printf("Directorio eliminado con éxito.\n");
	} 
	else 
	{
		fprintf(stderr, "Error al eliminar el directorio: %s\n", strerror(errno));
	}

	return 0;
}