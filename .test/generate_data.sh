if [ -z "$1" ]
then
    PYTHON_VERSION=3.6
else
    PYTHON_VERSION=$1
fi

git clone http://gitlab.com/bu_cnio/sc-test-data data
conda create -y -q -n bollito_snakemake snakemake python=${PYTHON_VERSION}
source activate bollito_snakemake
cd data
snakemake --use-conda
cd -
conda create -y -q -n bollito_prep star=2.7.1a
source activate bollito_prep
mkdir data/ref/genome.chr19.fa_idx
STAR --runMode genomeGenerate --genomeDir data/ref/genome.chr19.fa_idx --genomeFastaFiles data/ref/genome.chr19.fa --genomeSAindexNbases 11
conda deactivate
conda remove -n bollito_snakemake --all -y
conda remove -n bollito_prep --all -y
