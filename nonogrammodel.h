#ifndef NONOGRAMMODEL_H
#define NONOGRAMMODEL_H

#include <QAbstractItemModel>
#include "puzzle.h"

class NonogramModel : public QAbstractItemModel
{
    Q_OBJECT
    Q_PROPERTY(QVector<Puzzle> puzzles READ puzzles WRITE setPuzzles NOTIFY puzzlesChanged)
    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(QString theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(QVector<QString> columnDescription READ columnDescription WRITE setColumnDescription NOTIFY columnDescriptionChanged)
    Q_PROPERTY(QVector<QString> rowDescription READ rowDescription WRITE setRowDescription NOTIFY rowDescriptionChanged)
    Q_PROPERTY(QVector<int> solution READ solution WRITE setSolution NOTIFY solutionChanged)
    Q_PROPERTY(QVector<int> userSolution READ userSolution WRITE setUserSolution NOTIFY userSolutionChanged)


public:
    explicit NonogramModel(QObject *parent = nullptr);

    // Basic functionality:
    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &index) const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    // Properties getters:
    QVector<Puzzle> puzzles() const;
    int size() const;
    QString theme() const;
    QVector<QString> columnDescription() const;
    QVector<QString> rowDescription() const;
    QVector<int> solution() const;
    QVector<int> userSolution() const;

    Q_INVOKABLE void setUserSolutionSpecific(int position, int value);
    Q_INVOKABLE int getUserSolutionSpecific(int position);
    Q_INVOKABLE int checkUserSolution();
    Q_INVOKABLE void resetModel();


public slots:
    void setPuzzles(QVector<Puzzle> puzzles);
    void setSize(int size);
    void setTheme(QString theme);
    void setColumnDescription(QVector<QString> columnDescription);
    void setRowDescription(QVector<QString> rowDescription);
    void setSolution(QVector<int> solution);
    void setUserSolution(QVector<int> userSolution);

signals:
    void puzzlesChanged(QVector<Puzzle> puzzles);
    void sizeChanged(int size);
    void themeChanged(QString theme);
    void columnDescriptionChanged(QVector<QString> columnDescription);
    void rowDescriptionChanged(QVector<QString> rowDescription);
    void solutionChanged(QVector<int> solution);
    void userSolutionChanged(QVector<int> userSolution);

protected:
    int currentPuzzleNumber;
    void setPuzzleNumber();

private:
    QVector<Puzzle> m_puzzles;
    int m_size;
    QString m_theme;
    QVector<QString> m_columnDescription;
    QVector<QString> m_rowDescription;
    QVector<int> m_solution;
    QVector<int> m_userSolution;
};

#endif // NONOGRAMMODEL_H
