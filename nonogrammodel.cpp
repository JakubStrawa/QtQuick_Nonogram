#include "nonogrammodel.h"
#include "puzzlelist.h"

NonogramModel::NonogramModel(QObject *parent)
    : QAbstractItemModel(parent)
{
    PuzzleList list = PuzzleList();
    m_puzzles = list.puzzles;
    currentPuzzleNumber = -1;
    m_isActive = false;
}

// create index for row and column
QModelIndex NonogramModel::index(int row, int column, const QModelIndex &parent) const
{
    if (parent.isValid()) return QModelIndex();
    if (row >= m_puzzles.count() || column >= 7 || column < 0 || row < 0)
        return QModelIndex();
    return createIndex(row, column, nullptr);
}

QModelIndex NonogramModel::parent(const QModelIndex &index) const
{
    return QModelIndex();
}

int NonogramModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : m_puzzles.count();
}

int NonogramModel::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : 7;
}

// get data under index
QVariant NonogramModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || m_puzzles.count() == 0)
        return QVariant();

    if (role == Qt::DisplayRole)
    {
        Puzzle tmp = m_puzzles[index.row()];
        switch(index.column())
        {
        case 0: return tmp.getTheme();
        case 1: return tmp.getSize();
        case 2: return QVariant::fromValue(tmp.getSolution());
        case 3: return tmp.getRowDescription();
        case 4: return tmp.getColumnDescription();
        case 5: return QVariant::fromValue(this->userSolution());
        case 6: return this->isActive();
        default: return QVariant();
        }
    }
    else return QVariant();
}

bool NonogramModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid())
            return false;

    if (data(index, role) != value && role == Qt::DisplayRole)
    {
        if (index.column() == 0)
        {
            this->m_puzzles[index.row()].setTheme(value.toString());
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
        else if(index.column() == 1)
        {
            this->m_puzzles[index.row()].setSize(value.toInt());
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
        else if(index.column() == 2)
        {
            QVector<int> vector = value.value<QVector<int>>();
            this->m_puzzles[index.row()].addSolution(vector);
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
        else if(index.column() == 3)
        {
            QList<QString> list = value.toStringList();
            this->m_puzzles[index.row()].addRowDescription(list);
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
        else if(index.column() == 4)
        {
            QList<QString> list = value.toStringList();
            this->m_puzzles[index.row()].addColumnDescription(list);
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }
}

Qt::ItemFlags NonogramModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

void NonogramModel::setPuzzles(QVector<Puzzle> puzzles)
{
    if(puzzles.count() != m_puzzles.count())
    {
        // model size changed
        beginResetModel();
        m_puzzles = puzzles;
        endResetModel();
        emit puzzlesChanged(m_puzzles);
        return;
    }
    for(int i=0; i<m_puzzles.count(); i++)
    {
        if(m_puzzles[i] != puzzles[i])
        {
            // model content changed
            beginResetModel();
            m_puzzles = puzzles;
            endResetModel();
            emit puzzlesChanged(m_puzzles);
            return;
        }
    }
}

void NonogramModel::setSize(int size)
{
    m_size = size;
    setPuzzleNumber();
    emit sizeChanged(m_size);
}

void NonogramModel::setTheme(QString theme)
{
    m_theme = theme;
    setPuzzleNumber();
    emit themeChanged(m_theme);
}

void NonogramModel::setColumnDescription(QVector<QString> columnDescription)
{
    if (m_columnDescription == columnDescription)
        return;

    m_columnDescription = columnDescription;
    emit columnDescriptionChanged(m_columnDescription);
}

void NonogramModel::setRowDescription(QVector<QString> rowDescription)
{
    if (m_rowDescription == rowDescription)
        return;

    m_rowDescription = rowDescription;
    emit rowDescriptionChanged(m_rowDescription);
}

void NonogramModel::setSolution(QVector<int> solution)
{
    if (m_solution == solution)
        return;

    m_solution = solution;
    emit solutionChanged(m_solution);
}

void NonogramModel::setUserSolution(QVector<int> value)
{
    if (m_userSolution == value)
        return;

    m_userSolution = value;
    emit userSolutionChanged(m_userSolution);
}

void NonogramModel::setIsActive(bool isActive)
{
    if (m_isActive == isActive)
        return;

    m_isActive = isActive;
    emit isActiveChanged(m_isActive);
}

QVector<Puzzle> NonogramModel::puzzles() const
{
    return m_puzzles;
}

int NonogramModel::size() const
{
    return m_size;
}

QString NonogramModel::theme() const
{
    return m_theme;
}

QVector<QString> NonogramModel::columnDescription() const
{
    return m_columnDescription;
}

QVector<QString> NonogramModel::rowDescription() const
{
    return m_rowDescription;
}

QVector<int> NonogramModel::solution() const
{
    return m_solution;
}

QVector<int> NonogramModel::userSolution() const
{
    return m_userSolution;
}

void NonogramModel::setUserSolutionSpecific(int position, int value)
{
    if (m_userSolution[position] == value)
        return;

    m_userSolution[position] = value;
    emit userSolutionChanged(m_userSolution);
}

int NonogramModel::getUserSolutionSpecific(int position)
{
    return m_userSolution[position];
}

int NonogramModel::checkUserSolution()
{
    return m_puzzles[currentPuzzleNumber].checkWithSolution(m_userSolution);
}

bool NonogramModel::isActive() const
{
    return m_isActive;
}

void NonogramModel::setPuzzleNumber()
{
    for (int i=0; i<m_puzzles.count(); i++)
    {
        if (m_puzzles[i].getTheme() == this->theme() && m_puzzles[i].getSize() == this->size())
        {
            this->currentPuzzleNumber = i;
            this->setRowDescription(m_puzzles[i].getRowDescription());
            this->setColumnDescription(m_puzzles[i].getColumnDescription());
            this->setSolution(m_puzzles[i].getSolution());
            this->setIsActive(true);
            QVector<int> userSol = {};
            for(auto i : this->m_solution)
               userSol.append(0);
            this->setUserSolution(userSol);
            return;
        }
    }
    this->currentPuzzleNumber = -1;
}
