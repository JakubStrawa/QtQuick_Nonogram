#include "puzzle.h"

// operator == for Puzzle class
bool Puzzle::operator==(const Puzzle &puzzle)
{
    if(this->solution == puzzle.solution && this->rows == puzzle.rows && this->columns == puzzle.columns && this->theme == puzzle.theme)
    {
        return true;
    } else
    {
        return false;
    }
}

// operator != for Puzzle class
bool Puzzle::operator!=(const Puzzle &puzzle)
{
    if(this->solution == puzzle.solution && this->rows == puzzle.rows && this->columns == puzzle.columns && this->theme == puzzle.theme)
    {
        return false;
    } else
    {
        return true;
    }
}

int Puzzle::getSize() const
{
    return size;
}

void Puzzle::setSize(int value)
{
    size = value;
}

Puzzle::Puzzle()
{
}

Puzzle::Puzzle(int size)
{
    this->size = size;
}

Puzzle::~Puzzle()
{
}

void Puzzle::addSolution(QVector<int> &solution)
{
    if(solution.size() == size*size)
    {
        this->solution = solution;
    }
}

QVector<int> Puzzle::getSolution()
{
    return solution;
}

void Puzzle::addRowDescription(QVector<QString> &rows)
{
    if(rows.size() == size)
    {
        this->rows = rows;
    }
}

QVector<QString> Puzzle::getRowDescription()
{
    return rows;
}

void Puzzle::addColumnDescription(QVector<QString> &columns)
{
    if(columns.size() == size)
    {
        this->columns = columns;
    }
}

QVector<QString> Puzzle::getColumnDescription()
{
    return columns;
}

void Puzzle::setTheme(QString theme)
{
    if(!theme.isEmpty())
    {
        this->theme = theme;
    }
}

QString Puzzle::getTheme()
{
    return theme;
}

// check puzzle solution with user solution given as value parameter
int Puzzle::checkWithSolution(QVector<int> &value)
{
    int mistakes = 0;
    if(value.size() != solution.size())
    {
        return -1;
    }
    for(int i=0; i<solution.size(); i++)
    {
        if(solution[i] != value[i] && solution[i] == 1)
        {
            mistakes++;
        }
    }
    return mistakes;;
}
